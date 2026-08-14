pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  // an expression can be broken across multiple lines using {}
  readonly property string time: {
    // The passed format string matches the default output of
    // the `date` command.
    Qt.formatDateTime(clock.date, " hh:mm:ss ")
    
    //extra things to add ddd MMM d /AP t yyyy
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}