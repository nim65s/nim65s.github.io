#!/usr/bin/env python3
"""Generate public/index.html."""

from datetime import datetime
from json import loads
from pathlib import Path
from subprocess import check_output
from urllib.parse import urlparse

from jinja2 import Environment


def url_format(value):
    return urlparse(value).hostname


def get_talks():
    talks = []

    old = Path("public/.old-talks.json")
    if old.exists():
        talks = [[y, m, d, "talks", s, f] for (y, m, d, s, f) in loads(old.read_text())]

    for f in Path("talks").glob("*.typ"):
        meta = {"urls": []}
        for entry in loads(
            check_output(["typst", "query", "--root", ".", f, "metadata"])
        ):
            label = entry["label"].strip("<>")
            if label == "urls":
                name, url = entry["value"].split("|")
                meta[label].append({"name": name, "url": url})
            else:
                meta[label] = entry["value"]
        date = datetime.strptime(meta["date"], "%Y-%m-%d")
        y = date.year
        m = date.month
        d = date.day
        talks.append([y, m, d, "talks", f.stem, meta])

    return sorted(talks, reverse=True)


def main():
    env = Environment()
    env.filters["url_format"] = url_format
    template = env.from_string(Path("template.html").read_text())
    icons = ["creativecommons", "github", "gitlab"]
    talks = get_talks()
    ctx = {
        "page": "Talks",
        "files": talks,
        **{icon: Path(f"public/{icon}.svg").read_text() for icon in icons},
    }
    Path("public/talks.html").write_text(template.render(ctx))


if __name__ == "__main__":
    main()
