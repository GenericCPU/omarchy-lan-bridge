import QtQuick
import Quickshell
import qs.Commons
import qs.Ui

// Deliberately small: the bar is a status/control surface, while the Lan Mouse
// window owns pairing and screen-edge placement. This avoids putting network
// credentials or peer addresses in QML or the shell configuration.
BarWidget {
  id: root
  moduleName: "lan-bridge"

  property bool running: false

  function refresh() {
    probe.running = true
  }

  function openBridge() {
    Quickshell.execDetached(["lan-mouse"])
    refresh()
  }

  function openDropFolder() {
    Quickshell.execDetached(["xdg-open", Quickshell.env("HOME") + "/Lan Drop"])
  }

  Component.onCompleted: refresh()

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: root.refresh()
  }

  Process {
    id: probe
    command: ["bash", "-lc", "pgrep -x lan-mouse >/dev/null"]
    onExited: function(code) { root.running = code === 0 }
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    iconName: "󰌌"
    tooltipText: root.running
      ? "Lan Bridge connected — left: controls, right: shared drop folder"
      : "Lan Bridge — set up your second computer"
    onPressed: function(mouseButton) {
      if (mouseButton === Qt.RightButton) root.openDropFolder()
      else root.openBridge()
    }
  }
}
