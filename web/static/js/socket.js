import {Socket} from "phoenix"

let socket = new Socket("/socket", {})
socket.connect()

let elem = document.getElementById("status_id")
if (elem && elem.value) {
  let channel = socket.channel("room:" + elem.value, {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })
  channel.on("completed", msg => {
    let a = document.createElement("a")
    a.setAttribute("href", msg.url)
    a.textContent = "Download"
    let target = document.getElementById("alert")
    target.textContent = null
    target.appendChild(a)
  })
  channel.on("failed", msg => { alert("failed") })
  channel.push("status", { status_id: elem.value })
}

export default socket
