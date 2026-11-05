// Minimal Stream Deck plugin, no deps (Node 24 has a global WebSocket).
// Key on = a child `caffeinate -di` keeps display + system awake; key off = kill it.
const { spawn } = require("node:child_process");

const arg = (name) => process.argv[process.argv.indexOf(name) + 1];
const contexts = new Set();
const ws = new WebSocket(`ws://127.0.0.1:${arg("-port")}`);
const send = (msg) => ws.readyState === WebSocket.OPEN && ws.send(JSON.stringify(msg));

let caffeinate = null; // running child process, or null when off

function refresh() {
  const state = caffeinate ? 1 : 0;
  for (const context of contexts) send({ event: "setState", context, payload: { state } });
}

function toggle() {
  if (caffeinate) return caffeinate.kill(); // its exit handler clears state
  // -w: caffeinate exits by itself if this plugin dies, so the Mac never stays stuck awake.
  caffeinate = spawn("/usr/bin/caffeinate", ["-di", "-w", String(process.pid)], { stdio: "ignore" });
  caffeinate.on("exit", () => { caffeinate = null; refresh(); });
  refresh();
}

ws.onopen = () => send({ event: arg("-registerEvent"), uuid: arg("-pluginUUID") });
ws.onmessage = ({ data }) => {
  const { event, context } = JSON.parse(data);
  if (event === "willAppear") { contexts.add(context); refresh(); }
  if (event === "willDisappear") contexts.delete(context);
  if (event === "keyDown") toggle();
};
ws.onclose = () => process.exit(0);
