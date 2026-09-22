# GRSP Correlator v0.1.0 output schema

## `GRSP_Combined_Frames.csv`

One row per CapFrameX frame successfully aligned to a GRSP frame.

Important groups:

- `capx_*` — rendered frametime / CapFrameX evidence
- `grsp_*` — GRSP per-frame and spike evidence
- `cet_exact_*` — exact CET spike that overlaps this frame, when one exists
- `cet_bucket_*` — continuous 50 ms CET workload evidence
- `scheduler_*` — exact 0-Engine scheduler spike evidence, when present
- `evidence_class` — heuristic evidence label used by the HTML report

`cet_exact_exclusive_ms` is the measured work of the full CET spike event, while `cet_exact_overlap_ms` is the wall-clock portion of that event interval overlapping the aligned frame. They are intentionally separate.

## `GRSP_Combined_Timeline.csv`

Common 50 ms timeline anchored to GRSP capture start.

- `capx_avg_frametime_ms`
- `capx_max_frametime_ms`
- counts of frames crossing 33.3 / 50 / 100 ms
- `grsp_observed_exclusive_ms`
- GRSP top owner in the bucket
- `cet_observed_exclusive_ms`
- CET top mod in the bucket

CET and GRSP values are evidence layers and are not guaranteed to sum to wall-clock bucket time.

## `GRSP_Combined_Hitches.csv`

Subset of `GRSP_Combined_Frames.csv` where CapFrameX frametime is at least 33.3 ms, sorted by descending frametime.

## `GRSP_Correlator_Status.txt`

Human-readable discovery, sync, health and output diagnostics. This is the first file to inspect if the HTML report reports `FAIR` or `POOR` synchronization.

## AI / machine-readable outputs

### `GRSP_Analysis.json`

Compact structured summary containing synchronization quality, capture health, performance statistics, top REDscript owners, top CET owners, and the 100 largest hitches.

### `GRSP_AI_Analysis.md`

Compact Markdown version intended for human review or attaching directly to an AI assistant. It contains interpretation rules, synchronization and health data, top owners, and the 50 largest hitches.

### `GRSP_Analysis_Package.zip`

Portable package containing the HTML report, all combined CSV outputs, the AI Markdown/JSON files, and status text.
