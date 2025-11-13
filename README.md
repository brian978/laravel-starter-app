# Laravel Starter App — Docker template

A lightweight Docker template for local Laravel development. Bring up a full stack in seconds and focus on building your app instead of wiring up infrastructure.

## Table of Contents
- What this template is useful for
- Services
  - Basic services
  - Extra services (optional)
- Quick start
- Flexible setup and extras
- Examples
- Vite HMR configuration (important)

## What this template is useful for
- Local Laravel development using Docker, with a ready-to-run stack that includes Nginx, PHP-FPM, MariaDB, and Memcached.
- Optional extras for RabbitMQ and Microsoft SQL Server.
- Quick bootstrap commands via Makefile and helper scripts.

## Services

### Basic services
- Nginx
- PHP-FPM
- MariaDB
- Memcached

### Extra services (optional)
- Microsoft SQL Server: 2017 (latest)
- RabbitMQ

## Quick start
1) Start the stack

```bash
make start
```

- Enabling optional services via Makefile:

```bash
make start EXTRAS="rabbit"          # start with RabbitMQ
make start EXTRAS="msql"            # start with Microsoft SQL Server
make start EXTRAS="rabbit msql"     # start with both
```

- Convenience shortcut:

```bash
make start-all
```

2) Install Laravel into the app directory

```bash
make install
```

3) Open a shell in the PHP container (provisioned bash)

```bash
make cli
```

4) Stop the stack (when done)

```bash
make stop
```

## Flexible setup and extras
The base configuration only includes Nginx, PHP, MySQL and Memcached. If you want the other services, pass one of the following parameters to the run script (or use the Makefile EXTRAS shown above):
- rabbit — enable RabbitMQ
- msql — enable Microsoft SQL Server

## Examples

Using the Makefile (recommended):

```bash
# RabbitMQ support
make start EXTRAS="rabbit"

# Microsoft SQL Server support
make start EXTRAS="msql"

# Both services
make start EXTRAS="rabbit msql"  # or: make start-all
```

Using the run script directly (advanced):

```bash
# Adding RabbitMQ support
sh scripts/run.sh rabbit

# Adding Microsoft SQL Server support
sh scripts/run.sh msql

# Adding support for both
sh scripts/run.sh rabbit msql
```

## Vite HMR configuration (important)
After installing Laravel (step 2), configure Vite to use localhost for HMR. Edit vite.config.js in your project and add the server.hmr.host setting:

```javascript
// vite.config.js
import { defineConfig } from 'vite'
import laravel from 'laravel-vite-plugin'

export default defineConfig({
  // ...
  server: {
    hmr: {
      host: 'localhost',
    },
  },
})
```

> **Note:** This ensures hot module replacement works correctly when accessing the app through the local environment.

