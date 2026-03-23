#!/usr/bin/env python3
"""Fetch a web page via Playwright headless Chrome → stdout as HTML/text.

Privacy-safe: all processing is local (no external API calls).
Use this for confidential/authenticated pages instead of Jina Reader.

Fallback: if Playwright fails, prints nothing and exits with code 2,
signaling the caller that local fetch has failed. The caller (SKILL.md)
decides the next action based on the URL's privacy classification.

Usage:
  fetch-page.py URL                    # HTML output (default)
  fetch-page.py URL --text             # innerText output
  fetch-page.py URL --wait-for "selector"  # wait for CSS selector before extracting
  fetch-page.py URL --timeout 30       # timeout in seconds for page load + selector wait (default: 20 each)
  fetch-page.py URL --visible          # force visible browser (debug)

Requirements:
  - Python 3.10+ with playwright library
  - System Chrome (preferred, better bot detection avoidance) or
    Chromium installed via: playwright install chromium
"""

import argparse
import os
import shutil
import sys
from urllib.parse import urlparse

from playwright.sync_api import sync_playwright, TimeoutError as PlaywrightTimeout

PROFILE_DIR = os.environ.get(
    "SCOUT_CHROME_PROFILE",
    os.path.join(os.path.dirname(os.path.abspath(__file__)), ".chrome-profile"),
)


def fetch(
    url: str,
    text_mode: bool = False,
    wait_for: str | None = None,
    timeout: int = 20,
    headless: bool = True,
) -> str | None:
    """Fetch a page and return its content. Returns None on failure."""
    parsed = urlparse(url)
    if parsed.scheme not in ("http", "https"):
        print(f"Error: unsupported URL scheme: {parsed.scheme}", file=sys.stderr)
        return None

    os.makedirs(PROFILE_DIR, mode=0o700, exist_ok=True)

    # Use system Google Chrome if available (better bot detection avoidance),
    # fall back to Playwright's bundled Chromium otherwise.
    channel = None
    for chrome_path in [
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
        shutil.which("google-chrome") or "",
    ]:
        if chrome_path and os.path.isfile(chrome_path):
            channel = "chrome"
            break

    with sync_playwright() as p:
        context = p.chromium.launch_persistent_context(
            user_data_dir=PROFILE_DIR,
            headless=headless,
            **({"channel": channel} if channel else {}),
            args=["--disable-blink-features=AutomationControlled"],
            locale=os.environ.get("SCOUT_LOCALE", "en-US"),
            viewport={"width": 1280, "height": 800},
            # No custom user_agent — let Playwright use its default
            # (matches the installed browser version, avoids bot detection)
        )
        try:
            page = context.new_page()
            page.add_init_script(
                'Object.defineProperty(navigator, "webdriver", { get: () => undefined });'
            )

            try:
                page.goto(url, wait_until="domcontentloaded", timeout=timeout * 1000)
            except PlaywrightTimeout:
                print(f"Error: page load timed out ({timeout}s)", file=sys.stderr)
                return None

            # Wait for JS rendering
            page.wait_for_timeout(2000)

            # Optional: wait for a specific element
            if wait_for:
                try:
                    page.wait_for_selector(wait_for, timeout=timeout * 1000)
                except PlaywrightTimeout:
                    print(
                        f"Warning: selector '{wait_for}' not found within {timeout}s. "
                        "Returning current page content.",
                        file=sys.stderr,
                    )

            if text_mode:
                content = page.evaluate("() => document.body?.innerText || ''")
            else:
                content = page.content()

            if not content or not content.strip():
                print("Error: empty page content", file=sys.stderr)
                return None

            return content

        finally:
            context.close()


def main():
    parser = argparse.ArgumentParser(
        description="Fetch a web page via Playwright headless Chrome (local processing)"
    )
    parser.add_argument("url", help="URL to fetch")
    parser.add_argument(
        "--text", action="store_true", help="Output innerText instead of HTML"
    )
    parser.add_argument(
        "--wait-for", help="CSS selector to wait for before extracting"
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=20,
        help="Page load timeout in seconds (default: 20)",
    )
    parser.add_argument(
        "--visible",
        action="store_true",
        help="Force visible browser (for debugging)",
    )
    args = parser.parse_args()

    content = fetch(
        url=args.url,
        text_mode=args.text,
        wait_for=args.wait_for,
        timeout=args.timeout,
        headless=not args.visible,
    )

    if content is None:
        sys.exit(2)  # signal: local fetch failed

    print(content)


if __name__ == "__main__":
    main()

