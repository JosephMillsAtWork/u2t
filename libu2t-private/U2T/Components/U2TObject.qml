import QtQuick 2.4
QtObject {
    id: object
    default property alias children: object.__childrenFix
    property list<QtObject> __childrenFix: [QtObject {}]
}
