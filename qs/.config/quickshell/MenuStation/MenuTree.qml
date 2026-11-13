import QtQuick

QtObject {
    property var tree: [
        {
            label: "Code ",
            children: [
                "Hyprland",
                "quickshell",
                "nvim",
                "website",
                "C"
            ]
        },
        {
            label: "Music ",
            children: [
                "Spotify",
                "ncmpcpp",
                "VLC"
            ]
        },
        {
            label: "Network",
            children: [
                "wifi",
                "ethernet",
                "vpn"
            ]
        },
        {
            label: "Mode ",
            children: [
                "gaming",
                "work",
                "silent"
            ]
        }
    ]
}
