#!/usr/bin/env bash
set -Eeuo pipefail -x

rm -f windows.tar
for dir in \
	moby-engine \
	moby-cli \
	moby-buildx \
; do
	img="$(cd "$dir/debian" && args=( docker build . --file Dockerfile.windows ) && "${args[@]}" >&2 && "${args[@]}" --quiet)"
	docker run --rm "$img" tar --create --blocking-factor 1 . | head --bytes=-1024 >> windows.tar
done
