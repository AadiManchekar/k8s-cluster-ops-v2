from flask import Flask, request, jsonify
import threading
import time
import math

app = Flask(__name__)

def cpu_intensive_task(duration):
    """Performs a CPU-intensive calculation for the given duration in seconds."""
    end_time = time.time() + duration
    while time.time() < end_time:
        # Simulating a CPU-intensive task with heavy computation
        math.factorial(5000)

@app.route('/trigger', methods=['POST'])
def trigger_task():
    data = request.get_json()
    duration = data.get('duration', 30)  # default to 30 seconds 

    # Start the CPU-intensive task in a separate thread
    task_thread = threading.Thread(target=cpu_intensive_task, args=(duration,))
    task_thread.start()

    return jsonify({"message": "Task started", "duration": duration})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
