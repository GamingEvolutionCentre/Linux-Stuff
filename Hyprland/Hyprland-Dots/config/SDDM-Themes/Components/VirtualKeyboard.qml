// Config created by GamingEvolutionCentre https://github.com/GamingEvolutionCentre/SDDM-Themes 
// Copyright (C) 2022-2025 GamingEvolutionCentre
// Distributed under the BSD 3-Clause License

import QtQuick 2.15
import QtQuick.VirtualKeyboard 2.3

InputPanel {
    id: virtualKeyboard
    
    property bool activated: false
    active: activated && Qt.inputMethod.visible
    visible: active
}
