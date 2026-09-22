# v0.1.0 reference validation

The first correlator build was tested against the real 2026-09-22 combined capture used to validate the three-profiler design.

## Synchronization

```text
GRSP start Unix ms:        1790049814037
CET CAPTURE_START Unix ms: 1790049814040
start delta:                         3 ms

GRSP duration: 414443.544 ms
CET duration:  414460.376 ms
duration delta:    16.832 ms

CapFrameX -> GRSP frame offset: +2 frames
frametime correlation:          0.972681
median frame-duration delta:    0.587800 ms
aligned frame pairs:            21,312
```

GRSP and CET both reported zero dropped records in the relevant capture-health fields.

## Known-event checks

The generated report correctly matched examples including:

```text
~209.245 s
CapFrameX: ~223.98 ms
CET: NightCityBilliards / PlayerPuppet::OnAction ~200.88 ms
GRSP: ~1.33 ms
=> CET_HEAVY
```

```text
~74.681 s
CapFrameX: ~193.78 ms
CET: 0-Engine / PlayerPuppet::OnAction ~138.62 ms
GRSP: ~23.54 ms
=> MIXED_SCRIPT_SIGNAL
```

```text
~322.726 s
CapFrameX: ~457.11 ms
GRSP: ~2.70 ms
no overlapping major CET spike
=> LARGELY_UNEXPLAINED
```

This reference dataset is intentionally not bundled with the source package.
