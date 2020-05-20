var component;
var text;

function createRole(name, number, parentItem){
    component = Qt.createQmlObject('import QtQuick 2.7; Text{ text: "'+name+'-'+number+'"; color: "light grey"; font.pointSize: 13; leftPadding: 10}',
                                    parentItem, 
                                    "roleFolder");
}
function createDesc(name, parentItem){
    component = Qt.createQmlObject('import QtQuick 2.7; Text{ text: "'+name+'"; color: "light grey"; font.pointSize: 10; leftPadding: 10}',
                                    parentItem, 
                                    "roleFolder");
}
function assignToRole(name, color, parentItem){
    component = Qt.createQmlObject('import QtQuick 2.7; Text{ text: "'+name+'"; color: "'+color+'"; font.pointSize: 13; leftPadding: 10}',
                                    parentItem, 
                                    "membersnippet");//change name
}
function createColumn(botpad, parentItem){
    component = Qt.createQmlObject('import QtQuick 2.7; Column{bottomPadding: '+botpad+'}',
                                    parentItem,
                                    "testColumn");
    return component;
}
function createRow(parentItem){
    component = Qt.createQmlObject('import QtQuick 2.7; Row{}',
                                    parentItem,
                                    "testRow");
    return component;
}
function createIcon(parentItem){
    component = Qt.createQmlObject('import QtQuick 2.7; Text{ text: "place\nholder"; color: "white"; font.pointSize: 13; leftPadding: 10}',
                                    parentItem,
                                    "icon");
}