#!/usr/bin/env bash

# Get the URL from docker-compose with error handling
if ! command -v docker-compose > /dev/null; then
    echo "Error: docker-compose not found. Please install Docker Compose."
    exit 1
fi

url_output=$(docker-compose port webserver 80 2>/dev/null)
if [ $? -ne 0 ] || [ -z "$url_output" ]; then
    echo "Error: Could not get webserver port from docker-compose. Make sure containers are running."
    exit 1
fi

url="http://$(echo "$url_output" | sed 's/0.0.0.0/localhost/')"

# Detect operating system and open URL accordingly
case "$(uname -s)" in
    Darwin*)
        # macOS
        if command -v open > /dev/null; then
            open "$url"
        else
            echo "Error: 'open' command not found on macOS"
            exit 1
        fi
        ;;
    Linux*)
        # Linux (including Debian)
        if command -v xdg-open > /dev/null; then
            xdg-open "$url"
        elif command -v gnome-open > /dev/null; then
            gnome-open "$url"
        elif command -v kde-open > /dev/null; then
            kde-open "$url"
        else
            echo "Error: No suitable command found to open URLs on Linux"
            echo "Please install xdg-utils package or use: $url"
            exit 1
        fi
        ;;
    CYGWIN*|MINGW*|MSYS*)
        # Windows (Git Bash, MSYS2, Cygwin)
        if command -v start > /dev/null; then
            start "$url"
        elif command -v cmd > /dev/null; then
            cmd /c start "$url"
        else
            echo "Error: Could not find command to open URLs on Windows"
            echo "Please open manually: $url"
            exit 1
        fi
        ;;
    *)
        # Fallback for unknown systems
        echo "Unknown operating system. Trying common commands..."
        if command -v open > /dev/null; then
            open "$url"
        elif command -v xdg-open > /dev/null; then
            xdg-open "$url"
        elif command -v start > /dev/null; then
            start "$url"
        else
            echo "Error: Could not detect suitable command to open URLs"
            echo "Please open manually: $url"
            exit 1
        fi
        ;;
esac

echo "Opening: $url"