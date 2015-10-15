TEMPLATE = app
QT -= gui
CONFIG += console

win32:QMAKE_CXXFLAGS += -WX -W3
unix:QMAKE_CXXFLAGS += -Wall -Werror

!win32 {
    RCC_DIR= ../release
    DESTDIR = ../release
    OBJECTS_DIR = ../release/.obj
    MOC_DIR = ../release/.moc
    RCC_DIR = ../release/.rcc
    UI_DIR = ../release/.ui
}

SOURCES += *.cpp
HEADERS += *.h
