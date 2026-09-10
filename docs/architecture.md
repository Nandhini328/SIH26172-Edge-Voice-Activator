# System Architecture

## End-to-end flow

```text
INMP441 microphone
       ↓
I2S audio capture @ 16 kHz mono
       ↓
Ring buffer / sliding window
       ↓
Energy + ZCR fast rejection
       ↓
MFE / MFCC feature extraction
       ↓
Lightweight CNN / DS-CNN
       ↓
INT8 TinyML inference
       ↓
Confidence + temporal verification
       ↓
Wake word decision
       ├── No → continue listening
       └── Yes → begin audio streaming
                         ↓
                    WebSocket
                         ↓
                    Remote ASR
                         ↓
                   Text / command
```

## Design principle

The always-listening stage performs wake-word detection locally on the edge MCU. Network transmission is activated only after a confident wake-word decision. This separates low-power local activation from the higher-power active streaming stage.

## Hardware

- ESP32-S3: edge MCU and Wi-Fi
- INMP441: I2S MEMS microphone
- USB-C: programming and power
- LED/resistor: local status indication
- Optional power monitor: current/voltage logging

## Embedded processing blocks

1. Audio acquisition: fixed-rate PCM samples from the I2S microphone.
2. Ring buffer: continuous fixed-memory history for sliding windows and pre-roll.
3. Acoustic screening: lightweight energy and zero-crossing-rate checks before ML.
4. Feature extraction: MFE/MFCC representation compatible with the trained model.
5. TinyML inference: quantized INT8 wake-word classifier.
6. Decision logic: confidence threshold plus temporal verification/debounce.
7. Streaming: send subsequent command audio only after activation.
