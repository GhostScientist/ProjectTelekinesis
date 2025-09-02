
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
import subprocess
import pyautogui
import base64

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/run")
async def run_command(req: Request):
    data = await req.json()
    prompt = data.get("prompt", "")
    try:
        result = subprocess.run(prompt, shell=True, capture_output=True, text=True)
        return {
            "prompt": prompt,
            "stdout": result.stdout,
            "stderr": result.stderr
        }
    except Exception as e:
        return {"error": str(e)}

@app.get("/screenshot")
def screenshot():
    try:
        image = pyautogui.screenshot()
        image_path = "/tmp/screen.jpg"
        image.save(image_path)
        with open(image_path, "rb") as f:
            return {
                "image_base64": base64.b64encode(f.read()).decode()
            }
    except Exception as e:
        return {"error": str(e)}
