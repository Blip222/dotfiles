pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io


Item{
    id: root
    property int barCount: 32;

    property var barLevels: {
        let initialLevels = [];
        for (let i=0; i < barCount; i++){
            initialLevels.push(0.0);

        }
        return initialLevels;
    }
    readonly property string cavaConfig: [
        "[general]",
        "bars = "+ root.barCount,
        "framerate = 60",
        "[output]",
        "method = raw",
        "raw_target = /dev/stdout",
        "data_format = ascii",
        "ascii_max_range = 1000",
        "bar_delimiter = 59"
    ].join("\n")

    Process {
        id: cavaProcess
        running: true

        command: [
            "bash", "-c",
            "cava -p <(printf '" + root.cavaConfig + "\n')"
        ]
        
        stdout: SplitParser{
            onRead: data => {
                let cleanData = data.trim()
                if(cleanData.length === 0) return;

                let tokens = cleanData.split(";")
                let availableTokens = Math.min(tokens.length, root.barCount)
                let nextLevels = []

                for (let i=0; i<root.barCount; i++){
                    let rawAmplitude = i < availableTokens ? (parseInt(tokens[i]) || 0): 0;
                    let normalizedLevel = Math.max(0.0, Math.min(1.0, rawAmplitude / 1000.0))
                    nextLevels.push(normalizedLevel);
                }
                root.barLevels = nextLevels;
            }
        }
    }
   }
