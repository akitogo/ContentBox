# ContentBox Workspace Instructions

These instructions help AI coding agents work productively in this repository.

## Scope And Priorities

- Prefer small, focused changes and preserve existing module boundaries.
- Do not move features between modules unless explicitly requested.
- Link to canonical docs in this repo instead of duplicating long guidance.

## Quick Start

1. Install project dependencies:
   - `box recipe workbench/setup.boxr`
2. Start local server (default is port `8589`):
   - `box server start`
3. Build frontend assets after clone and after asset changes:
   - `npm run build-dev`

## Canonical Commands

- Format code:
  - `box run-script format`
  - `box run-script format:check`
  - `box run-script format:watch`
- Test runners:
  - `http://127.0.0.1:8589/tests/runner.cfm`
  - `http://127.0.0.1:8589/tests/runner-api.cfm`
- Migrations:
  - `box run-script contentbox:migrate:create name=YourMigration`
  - `box run-script contentbox:migrate`
  - `box run-script contentbox:migrate:up`
  - `box run-script contentbox:migrate:down`
  - `box run-script contentbox:migrate:fresh`
- Frontend builds:
  - `npm run dev`
  - `npm run watch`
  - `npm run prod`
  - `npm run build-dev`
  - `npm run build-prod`

## Runtime And Persistence

- ContentBox uses CFML ORM backed by Hibernate (`this.ormEnabled = true`) configured in `Application.cfc`.
- Keep ORM settings and entity locations compatible with existing mappings in `Application.cfc`.
- Do not bypass migration scripts with ad hoc schema changes; use CommandBox migrations for DB evolution.
- When schema behavior changes, update migrations and tests together.

## Engine Support

- Keep changes compatible with the 3 supported engines:
  - Lucee
  - Adobe ColdFusion
  - BoxLang
- Use the existing server config files in repo root (`server-lucee@*.json`, `server-adobe@*.json`, `server-boxlang@*.json`) as the compatibility reference.

## Architecture Boundaries

- Root app (`/`) is the host ColdBox application and local development shell.
- `modules/contentbox/` is the core ContentBox engine and should remain self-contained.
- `modules_app/contentbox-custom/` is the customization layer for user-owned content/themes/widgets/modules.
- `modules/contentbox-installer/` is installation workflow code.

When implementing features/fixes:

- Keep core logic in `modules/contentbox/` unless it is customization-specific.
- Keep user/theme customizations in `modules_app/contentbox-custom/`.
- Avoid editing generated asset output directories under `includes/`.

## CFML And Style Conventions

- Target Lucee 5+ and Adobe ColdFusion 2018+ compatibility.
- Follow project formatting in `/.cfformat.json`.
- Run formatter before finalizing changes.
- Maintain DocBox-style CFC documentation for new public functions/components.

## Testing Expectations

- Add or update tests with all behavioral changes.
- Prefer existing test patterns in:
  - `tests/resources/BaseTest.cfc`
  - `tests/resources/BaseApiTest.cfc`
- Keep tests scoped to impacted area (`tests/specs/contentbox-web/` or `tests/specs/contentbox-api/`).
- Follow the current test layout:
  - API specs in `tests/specs/contentbox-api/`
  - Web/unit/integration specs in `tests/specs/contentbox-web/`
  - Shared fixtures/seeds/sql in `tests/resources/`
- If DB-backed tests are involved, verify test DB prerequisites from `tests/readme.md` and engine-specific DB scripts in `tests/resources/sql/`.

## Known Pitfalls

- Asset outputs in `modules/contentbox/modules/contentbox-admin/includes/` and theme `includes/` are generated and can be overwritten by builds.
- After asset/source changes, rebuild assets instead of manually editing compiled output.
- If tests require DB-backed integration behavior, verify local datasource prerequisites from test docs.

## PR And Branch Expectations

- Target PRs to `development`, not `master`.
- Include tests for fixes/features.
- Follow the repository PR template.

## Key References

- Contributor workflow: `CONTRIBUTING.md`
- Project overview/setup: `readme.md`
- Test setup details: `tests/readme.md`
- UI/asset workflow: `workbench/Developer.md`
- PR template: `.github/PULL_REQUEST_TEMPLATE.md`

## Agent Behavior In This Repo

- Prefer `rg` for file/text search.
- Read nearby code before editing to preserve local conventions.
- Avoid broad refactors unless explicitly requested.
- If command/tooling assumptions are unclear, verify in `box.json` and `package.json` first.