# ProjectTelekinesis
Project Telekinesis: A Reference Architecture for Remote AI-Augmented Computer Control.

**Project Telekinesis** is an experimental prototype exploring the possibilities and opportunities of agentic computing from a mobile device.

Current idea:
```
┌────────────────────┐
│    iOS App UI      │
│  • Chat interface  │
│  • Sends prompt    │
└────────┬───────────┘
         │
         ▼
┌────────────────────┐
│  Remote Mac Daemon │
│  • Receives prompt │
│  • Forwards to AI  │
│  • Runs commands   │
│  • Captures screen │
└────────┬───────────┘
         │
         ▼
┌──────────────────────────────┐
│   Claude API (Computer Use) │
│  • Interprets prompt         │
│  • Plans actions             │
│  • Simulates input/actions   │
└──────────────────────────────┘
         ▲
         │
         ▼
┌────────────────────┐
│    macOS System    │
│  • Executes tasks  │
│  • Responds to AI  │
│  • Screen updated  │
└────────┬───────────┘
         │
         ▼
┌────────────────────┐
│   iOS App UI       │
│  • Displays screen │
│  • Shows updates   │
└────────────────────┘
```
