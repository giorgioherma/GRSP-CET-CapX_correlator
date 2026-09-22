# GRSP Correlator v0.1.0

Standalone post-processing correlator for heavily modded Cyberpunk 2077 captures.

It combines three independent measurement layers:

- **GRSP 0.5.x** — observed REDscript work
- **CET Runtime Profiler v3 alpha6b-compatible output** — CET/Lua work and exact spike intervals
- **CapFrameX JSON** — rendered frametime

The correlator does **not** modify the game, CET, GRSP, or the source capture files. It only reads profiler output after the run.

## What it produces

A successful run writes:

- `GRSP_Combined_Report.html` — self-contained browser report
- `GRSP_Combined_Frames.csv` — one aligned row per CapFrameX frame
- `GRSP_Combined_Timeline.csv` — common 50 ms timeline
- `GRSP_Combined_Hitches.csv` — frames >= 33.3 ms, sorted by severity
- `GRSP_Correlator_Status.txt` — input discovery, synchronization and capture-health diagnostics

The HTML report includes:

- synchronization quality
- full combined timeline
- CapFrameX frametime
- GRSP observed REDscript work
- CET observed work
- exact CET spike attribution when available
- 0-Engine scheduler evidence when available
- bad-frame classifications
- top GRSP runtime owners
- top CET runtime owners
- dropped-event / capture-health checks

## Input layout

The easiest input is one ZIP or folder containing the three result sets. Folder names themselves are not important; the correlator discovers the files by schema.

Example:

```text
MyCapture.zip
  CET/
    CET_Runtime_Profile_Markers.csv
    CET_Runtime_Profile_Timeline.csv
    CET_Runtime_Profile_Spikes.csv
    ...

  GRSP/
    Capture_0001_.../
      GRSP_Summary.csv
      GRSP_Frames.csv
      GRSP_Timeline.csv
      GRSP_Spikes.csv
      GRSP_ByMod.csv
      ...

  CapX/
    CapFrameX-Cyberpunk2077.exe-....json
```

## Quick start on Windows

For the packaged `GRSP-Correlator.exe`, just **double-click the EXE**.

v0.1.2 opens a native file picker. Select the combined capture ZIP containing the GRSP, CET and CapFrameX results. If you cancel the ZIP picker, a folder picker is offered. The correlator then generates the combined report beside the input and opens `GRSP_Combined_Report.html` automatically.

You can also drag a combined capture ZIP onto the EXE, or use the command line as before.

## Run from Python

Python 3.10+ is sufficient and no third-party packages are required.

```powershell
py -3 GRSP_Correlator.py "D:\Captures\MyCapture.zip" --open
```

Or drag the ZIP/folder onto `Run_Correlator.bat`.

The default output is created beside the input. Use `-o` to choose a location:

```powershell
py -3 GRSP_Correlator.py "D:\Captures\MyCapture.zip" -o "D:\Captures\Combined"
```

## Synchronization model

GRSP is the common absolute-time axis.

**GRSP <-> CET**

CET's `CAPTURE_START` marker supplies `CaptureMs` and `UnixEpochMs`. CET events are mapped onto the GRSP Unix timeline from that anchor.

**CapFrameX <-> GRSP**

CapFrameX does not provide the same capture-start Unix epoch. The correlator therefore matches the actual frametime sequence against `GRSP_Frames.csv`, searches a small frame-offset window, and chooses the alignment with the strongest correlation.

The report exposes:

- GRSP/CET start delta
- GRSP/CET duration delta
- CapFrameX -> GRSP frame offset
- frametime correlation coefficient
- median and mean frame-duration mismatch

If those checks are weak, synchronization is reported as `FAIR` or `POOR` rather than silently presenting the capture as authoritative.

## Evidence classes

For frames >= 33.3 ms, the report labels the strongest synchronized evidence:

- `REDSCRIPT_HEAVY`
- `CET_HEAVY`
- `MIXED_SCRIPT_SIGNAL`
- `REDSCRIPT_SIGNAL`
- `CET_SIGNAL`
- `LARGELY_UNEXPLAINED`

These are **evidence labels, not causal verdicts** and not recommendations to remove mods.

`LARGELY_UNEXPLAINED` means neither GRSP nor the CET profiler showed a large script signal for that frame. It does **not** prove the time was native/engine/rendering work.

## Important measurement rule

The correlator intentionally does **not** calculate:

```text
CapFrameX frametime - GRSP - CET = native remainder
```

That subtraction is not generally valid:

- CET work can execute concurrently across threads.
- CET 50 ms buckets can cross frame boundaries.
- long CET events can span multiple buckets/frames.
- GRSP `exclusive_instrumented_ms` is observed instrumented-edge time, not guaranteed complete VM self-time.
- wrappers can include work performed under the wrapper.

The combined report therefore presents synchronized layers of evidence rather than pretending they are a single additive CPU budget.

## Windows EXE

The included GitHub Actions workflow builds a one-file Windows console executable with PyInstaller. The script itself remains dependency-free; PyInstaller is only a packaging dependency used by the build job.

## Compatibility target

v0.1.2 keeps the v0.1.0 correlation engine validated against:

- GRSP 0.5.0 Public Preview
- CET Runtime Profiler v3.0.0-alpha6b adaptive / 0-Engine core mode
- CapFrameX 1.8.6.2 JSON

See `VALIDATION.md` for the reference-capture results.


## Persistent output and AI analysis

Every run writes a persistent output folder beside the selected input capture. The browser opens the `GRSP_Combined_Report.html` file from that folder; it is not a temporary browser-only report.

v0.1.2 also creates:

- `GRSP_Analysis.json` — compact structured machine-readable analysis.
- `GRSP_AI_Analysis.md` — compact plain-text/Markdown report intended for attaching to an AI assistant.
- `GRSP_Analysis_Package.zip` — one portable ZIP containing the HTML, AI files, status and combined CSVs.

Interactive runs also open the saved output folder in Explorer after generation.
