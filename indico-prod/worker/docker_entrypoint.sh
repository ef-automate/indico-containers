#!/bin/bash

set -e

cleanup_podman_runtime() {
    local runtime_dir

    for runtime_dir in /tmp/storage-run-*; do
        [[ -e "$runtime_dir" || -L "$runtime_dir" ]] || continue
        [[ ! -L "$runtime_dir" ]] || {
            echo "Refusing to clean Podman runtime through symlink: $runtime_dir" >&2
            return 1
        }
        [[ -d "$runtime_dir" ]] || continue
        [[ ! -L "$runtime_dir/libpod" ]] || {
            echo "Refusing to clean Podman runtime through symlink: $runtime_dir/libpod" >&2
            return 1
        }

        if [[ -e "$runtime_dir/containers" || -L "$runtime_dir/containers" ||
              -e "$runtime_dir/libpod/tmp" || -L "$runtime_dir/libpod/tmp" ]]; then
            echo "Removing temporary Podman runtime state from $runtime_dir"
            rm -rf -- "$runtime_dir/containers" "$runtime_dir/libpod/tmp"
        fi
    done
}

cleanup_podman_runtime

source /opt/indico/.venv/bin/activate

exec "$@"
