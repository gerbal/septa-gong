// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import { Socket } from "phoenix"
import NProgress from "nprogress"
import { LiveSocket } from "phoenix_live_view"

// console.log("hi");

let Hooks = {}

Hooks.Gong = {
    mounted() {
        console.log("mounted")
        this.el.addEventListener("gong", e => {

            console.log(e)
        })
        this.handleEvent("gong", (vars) => {

            const sound = document.getElementById("gong-audio");
            sound.pause();
            sound.currentTime = 0;
            sound.play();

            console.log("GONG");
        })
    },

}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { params: { _csrf_token: csrfToken }, hooks: Hooks })

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// preload Audio Divs to maybe allow to be played in ios
function unlockAudio() {
    const sound = document.getElementById("gong-audio");
    const sound_2 = document.getElementById("voice-audio");

    const promise = sound.play();

    if (promise !== undefined) {
        promise.then(() => { }).catch(error => console.error);
    }
    sound.pause();
    sound.currentTime = 0;
    document.body.removeEventListener('click', unlockAudio)
    document.body.removeEventListener('touchstart', unlockAudio)
}

document.body.addEventListener('click', unlockAudio);
document.body.addEventListener('touchstart', unlockAudio);

