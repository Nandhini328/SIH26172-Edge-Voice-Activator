# ESP32-S3 Firmware

This directory will contain the production firmware for the physical prototype.

## Planned modules

```text
firmware/
├── src/
│   ├── main.cpp
│   ├── audio_capture.cpp
│   ├── ring_buffer.cpp
│   ├── feature_extraction.cpp
│   ├── inference.cpp
│   ├── wake_decision.cpp
│   ├── streaming.cpp
│   └── power_monitor.cpp
└── include/
```

## Runtime states

1. **LISTENING** – microphone capture, buffering, fast rejection and local KWS.
2. **WAKE_DETECTED** – confidence/temporal confirmation and network activation.
3. **STREAMING** – transmit subsequent command audio to the remote ASR service.
4. **COOLDOWN/RETURN** – stop streaming and return to local listening.

Hardware implementation and measured resource values are pending ESP32-S3 availability.
