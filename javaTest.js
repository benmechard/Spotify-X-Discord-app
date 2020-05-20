var component;
var text;

function createTextObjects(name, parentItem){
    component = Qt.createQmlObject('import QtQuick 2.7; Text{ text: "'+name+'"; color: "light grey"; font.pointSize: 13}',
                                    parentItem, 
                                    "testSnippet");
}
/*function assignToRole(name, color, parentItem, topRole, roleFolder){
    if (topRole == roleFolder){
        component = Qt.createQmlObject('import QtQuick 2.7; Text{ text: "'+name+'"; color: "'color'"; font.pointSize: 13}',
                                        parentItem, 
                                        "testSnippet");
    }
}*/