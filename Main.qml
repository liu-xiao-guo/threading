import QtQuick 2.0
import Ubuntu.Components 1.1

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "threading.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    Page {
        title: i18n.tr("threading")

        ListView {
            anchors.fill: parent
            model: listModel
            delegate: Component {
                Text { text: time }
            }

            ListModel { id: listModel }

            WorkerScript {
                id: worker
                source: "dataloader.js"
            }

            Timer {
                id: timer
                interval: 2000; repeat: true
                running: true
                triggeredOnStart: true

                onTriggered: {
                    var msg = {'action': 'appendCurrentTime', 'model': listModel};
                    worker.sendMessage(msg);
                }
            }
        }
    }
}

