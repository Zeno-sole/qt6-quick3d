// Copyright (C) 2020 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick3D
import QtQuick

Rectangle {
    width: 400
    height: 400
    color: Qt.rgba(0, 0, 0, 1)

    View3D {
        id: v3d
        anchors.fill: parent

        environment: SceneEnvironment {
            clearColor: "#444845"
            backgroundMode: SceneEnvironment.Color
        }

        camera: camera

        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 0, 600)
        }

        DirectionalLight {
            position: Qt.vector3d(-500, 500, -100)
            color: Qt.rgba(0.2, 0.2, 0.2, 1.0)
            ambientColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
        }

        property real time: 10
        property real amplitude: 20

        // just vertex, just fragment, both

        Model {
            source: "#Sphere"
            scale: Qt.vector3d(2, 2, 2)
            x: -200
            materials: [
                CustomMaterial {
                    property alias time: v3d.time
                    property alias amplitude: v3d.amplitude
                    vertexShader: "customsimple.vert"
                }
            ]
        }

        Model {
            source: "#Sphere"
            scale: Qt.vector3d(2, 2, 2)
            materials: [
                CustomMaterial {
                    fragmentShader: "customsimple.frag"
                }
            ]
        }

        Model {
            source: "#Sphere"
            scale: Qt.vector3d(2, 2, 2)
            x: 200
            materials: [
                CustomMaterial {
                    property alias time: v3d.time
                    property alias amplitude: v3d.amplitude
                    vertexShader: "customsimple.vert"
                    fragmentShader: "customsimple.frag"
                }
            ]
        }

        // Vertex shaders variant that do not override POSITION value
        Model {
            source: "#Sphere"
            scale: Qt.vector3d(2, 2, 2)
            x: -200
            y: -200
            materials: [
                CustomMaterial {
                    property alias time: v3d.time
                    property alias amplitude: v3d.amplitude
                    vertexShader: "customsimple_no_position.vert"
                }
            ]
        }

        Model {
            source: "#Sphere"
            scale: Qt.vector3d(2, 2, 2)
            x: 200
            y: -200
            materials: [
                CustomMaterial {
                    property alias time: v3d.time
                    property alias amplitude: v3d.amplitude
                    vertexShader: "customsimple_no_position.vert"
                    fragmentShader: "customsimple.frag"
                }
            ]
        }

    }
}
