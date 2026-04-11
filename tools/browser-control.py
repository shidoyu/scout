#!/usr/bin/env python3
"""Control a running Chrome instance via Playwright CDP connection.

Connects to Chrome's CDP endpoint (--remote-debugging-port=9222) using
Playwright's connect_over_cdp, replacing the chrome-devtools MCP server.

Subcommands:
  list-pages                              List open tabs (title + URL)
  snapshot [INDEX|SUBSTR] [--wait SEL]    Get page text content (default: first tab)
  screenshot PATH [INDEX|SUBSTR]          Save page screenshot to file
  evaluate SCRIPT [INDEX|SUBSTR]          Run JavaScript and print result
  navigate URL [INDEX|SUBSTR] [--wait S]  Navigate a tab to URL (default: first tab)

INDEX|SUBSTR matches by tab index (integer) or by title/URL substring.

Requirements:
  - Python 3.10+ with playwright
  - Chrome running with: --remote-debugging-port=9222 --user-data-dir=DIR

Exit codes:
  0  Success
  1  General error (no tabs, selector not found, empty content)
  2  Chrome not reachable (not running or port not open)
"""

import argparse
import json
import sys

from playwright.sync_api import (
    sync_playwright,
    Error as PlaywrightError,
    TimeoutError as PlaywrightTimeout,
)

DEFAULT_CDP_URL = "http://127.0.0.1:9222"


def connect_cdp(cdp_url: str):
    """Connect to Chrome via CDP and return (playwright, browser) tuple.

    On connection failure, prints instructions and exits with code 2.
    On other errors, cleans up and re-raises.
    """
    pw = sync_playwright().start()
    try:
        browser = pw.chromium.connect_over_cdp(cdp_url)
        return pw, browser
    except PlaywrightError as e:
        pw.stop()
        msg = str(e)
        if "ECONNREFUSED" in msg or "Could not connect" in msg:
            print(
                "Error: Cannot connect to Chrome CDP.\n"
                "Start Chrome in debug mode first:\n"
                '  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \\\n'
                "    --remote-debugging-port=9222 \\\n"
                "    --user-data-dir=$HOME/.chrome-debug",
                file=sys.stderr,
            )
            sys.exit(2)
        raise


def find_page(browser, selector: str | None = None):
    """Find a page by index, or title/URL substring. Returns the page."""
    contexts = browser.contexts
    pages = []
    for ctx in contexts:
        pages.extend(ctx.pages)

    if not pages:
        print("Error: no open tabs found", file=sys.stderr)
        sys.exit(1)

    if selector is None:
        return pages[0]

    # Try as integer index first
    try:
        idx = int(selector)
        if 0 <= idx < len(pages):
            return pages[idx]
        print(f"Error: index {idx} out of range (0-{len(pages) - 1})", file=sys.stderr)
        sys.exit(1)
    except ValueError:
        pass

    # Search by URL or title substring
    needle = selector.lower()
    for page in pages:
        if needle in page.url.lower() or needle in (page.title() or "").lower():
            return page

    print(f"Error: no tab matching '{selector}'", file=sys.stderr)
    sys.exit(1)


def wait_for_selector(page, wait_for: str | None, timeout: int = 10):
    """Wait for a CSS selector if specified."""
    if not wait_for:
        return
    try:
        page.wait_for_selector(wait_for, timeout=timeout * 1000)
    except PlaywrightTimeout:
        print(
            f"Warning: selector '{wait_for}' not found within {timeout}s. "
            "Returning current content.",
            file=sys.stderr,
        )


def cmd_list_pages(browser, **_):
    """List all open tabs."""
    contexts = browser.contexts
    idx = 0
    for ctx in contexts:
        for page in ctx.pages:
            title = page.title() or "(no title)"
            print(f"[{idx}] {title}")
            print(f"    {page.url}")
            idx += 1
    if idx == 0:
        print("No open tabs found.", file=sys.stderr)
        sys.exit(1)


def cmd_snapshot(browser, selector: str | None = None, wait_for: str | None = None, **_):
    """Get page text content."""
    page = find_page(browser, selector)
    wait_for_selector(page, wait_for)
    text = page.evaluate("() => document.body?.innerText || ''")
    if text and text.strip():
        print(text)
    else:
        print("Error: empty page content", file=sys.stderr)
        sys.exit(1)


def cmd_screenshot(browser, path: str, selector: str | None = None, **_):
    """Save page screenshot."""
    page = find_page(browser, selector)
    page.screenshot(path=path, full_page=True)
    print(f"Screenshot saved: {path}")


def cmd_evaluate(browser, script: str, selector: str | None = None, **_):
    """Evaluate JavaScript on a page."""
    page = find_page(browser, selector)
    result = page.evaluate(script)
    if result is not None:
        if isinstance(result, (dict, list)):
            print(json.dumps(result, ensure_ascii=False, indent=2))
        else:
            print(result)


def cmd_navigate(browser, url: str, selector: str | None = None, wait_for: str | None = None, **_):
    """Navigate a tab to a URL."""
    page = find_page(browser, selector)
    page.goto(url, wait_until="domcontentloaded", timeout=30000)
    wait_for_selector(page, wait_for)
    print(f"Navigated to: {page.url}")


def main():
    parser = argparse.ArgumentParser(
        description="Control Chrome via Playwright CDP connection"
    )
    parser.add_argument(
        "--cdp-url",
        default=DEFAULT_CDP_URL,
        help=f"CDP endpoint URL (default: {DEFAULT_CDP_URL})",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("list-pages", help="List open tabs")

    p_snap = sub.add_parser("snapshot", help="Get page text content")
    p_snap.add_argument("selector", nargs="?", help="Tab index or title/URL substring")
    p_snap.add_argument("--wait-for", help="CSS selector to wait for before extracting")

    p_ss = sub.add_parser("screenshot", help="Save page screenshot")
    p_ss.add_argument("path", help="Output file path")
    p_ss.add_argument("selector", nargs="?", help="Tab index or title/URL substring")

    p_eval = sub.add_parser("evaluate", help="Run JavaScript on page")
    p_eval.add_argument("script", help="JavaScript to evaluate")
    p_eval.add_argument("selector", nargs="?", help="Tab index or title/URL substring")

    p_nav = sub.add_parser("navigate", help="Navigate tab to URL")
    p_nav.add_argument("url", help="URL to navigate to")
    p_nav.add_argument("selector", nargs="?", help="Tab index or title/URL substring")
    p_nav.add_argument("--wait-for", help="CSS selector to wait for after navigation")

    args = parser.parse_args()

    pw = None
    browser = None
    try:
        pw, browser = connect_cdp(args.cdp_url)
        commands = {
            "list-pages": cmd_list_pages,
            "snapshot": cmd_snapshot,
            "screenshot": cmd_screenshot,
            "evaluate": cmd_evaluate,
            "navigate": cmd_navigate,
        }
        cmd_func = commands[args.command]
        cmd_kwargs = vars(args)
        cmd_kwargs.pop("command")
        cmd_kwargs.pop("cdp_url")
        cmd_func(browser, **cmd_kwargs)
    finally:
        # Disconnect without closing Chrome.
        # Do NOT call browser.close() — that may terminate the user's Chrome.
        if pw:
            pw.stop()


if __name__ == "__main__":
    main()
