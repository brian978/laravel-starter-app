# Project Overview

This application is using Laravel 12 or newer.

# Contributing
1. When working on an issue, please create a branch with the issue number: `feat/123-my-feature`
   1. If instructed to `implement the issue in a worktree`, then create the branch in the worktree, ALWAYS starting from `master`.
2. Make sure to follow the coding standards PER v3.0
3. When committing, use conventional commits. You will only commit and push the changes to the remote repository when I say `all done`
4. The title of the Pull Request should follow the conventional commits format
5. NEVER merge to master
6. NEVER push to master
7. Always develop using TDD and follow the coding standards
8. Follow coding principles and patterns as much as possible. Use SOLID, DRY, KISS, etc.
9. ALWAYS use strong typing.

## Useful commands
If you need to run PHP commands, you need to first connect to the container. You can use the make cli command for this.

Commands:
- `make docker-build`: will build the project.
- `make start`: will start the project.
- `make stop`: will stop the project.
- `make cli`: will connect to the container. This is where you can run `phpunit`, `php` and `composer` commands.
- `docker-compose run --rm app /bin/bash -c "php artisan test"`: This will run the tests inside the container.

### Laravel Commands
All Laravel commands must be run inside the Docker container:
- **Migrations**: `php artisan migrate`
- **Seeders**: `php artisan db:seed`
- **Tinker**: `php artisan tinker`

## Testing
IMPORTANT: Always run tests after there are no more changes to be done, ONLY IF you are changing PHP files that are not
blade templates

- **Run Tests**: `docker-compose run --rm -it app /bin/bash -c 'php artisan test'`
- **Test Suites**: Unit, Integration, and Feature tests (configured in app/phpunit.xml)

In case you need to create files that you require to test something, make sure you remove them. For example, if you
need to create a file like `test-modal.blade.php` in order to test a modal, be sure to remove it when done.

## Project Structure Notes

- Main application code is in `app/app/` directory
- Frontend assets in `app/resources/`
- Database migrations follow Laravel 11 conventions
- Docker configuration separates development and VPS deployment
- Tests organized by Unit, Integration, and Feature categories

## Development Patterns

- Services use dependency injection and follow a single responsibility principle
- Database transactions for critical operations (invoices, financial data, orders, etc.)
- Multi-currency support with automatic conversion to EUR
- Graceful fallback mechanisms for external API failures
- Policy-based authorization for resource access