# GRSP Correlator 0.1.1

Usability fix for direct launching.

## Changed

- double-clicking `GRSP-Correlator.exe` with no arguments now opens a native capture picker
- cancelling the ZIP picker offers a folder picker
- console path entry remains as a fallback if a GUI picker is unavailable
- interactive runs automatically open the generated HTML report
- interactive errors keep the console open so the error can actually be read
- successful interactive runs keep the console open until Enter is pressed
- drag/drop and command-line behavior remain supported
- no correlation, alignment, classification, or measurement logic changed

---

# GRSP Correlator 0.1.0

First working post-processing correlator.

## Included

- automatic discovery from a combined folder or ZIP
- GRSP/CET Unix-clock alignment
- automatic CapFrameX-to-GRSP frame-sequence alignment
- synchronization-health scoring
- common 50 ms timeline
- exact CET spike overlap matching
- 0-Engine scheduler spike matching
- GRSP per-frame and spike evidence
- bad-frame evidence classes
- self-contained interactive HTML report
- combined frame, timeline and hitch CSV exports
- zero third-party Python runtime dependencies
- GitHub Actions Windows one-file EXE build

## Deliberately not included

- naïve `frametime - GRSP - CET` remainder math
- uninstall recommendations
- dependency assumptions
- changes to the GRSP DLL hot path
- changes to CET profiler alpha6b
