'use strict'
/**
 * Slate Javasript configuration file
 */
S.log('[SLATE] --- Started Loading config from .slate.js ---')
// helpers
const mod = key => `${key}:ctrl,shift`

const screens = {
  mac: {
    id: 0,
    resolution: '1650x1050',
  },
  main: {
    id: 1,
    resolution: '3008x1692',
  },
  // right: {
  //   id: 2,
  //   resolution: '2560x1440',
  // },
}

const applications = {
  '1': 'Alacritty',
  '2': 'Firefox',
  '3': 'Slack',
  '4': 'PhpStorm',
  '5': 'Firefox',
  '6': 'Mail Hypotheekbond',
  '7': 'WhatsApp',
  '8': 'Agenda Hypotheekbond',
  '9': 'Abstract',
  '0': 'TimeChimp Hypotheekbond',
}

const pushedLeft = win => {
  if (!win) return false
  const winRect = win.rect()
  const screen = win.screen().visibleRect()
  return (
    winRect.x === screen.x &&
    winRect.y === screen.y &&
    winRect.width === screen.width/2 &&
    winRect.height === screen.height
  )
}

const pushedRight = win => {
  if (!win) return false
  const winRect = win.rect()
  const screen = win.screen().visibleRect()
  return (
    winRect.x === screen.x + screen.width/2 &&
    winRect.y === screen.y &&
    winRect.width === screen.width/2 &&
    winRect.height === screen.height
  )
}

const isFullscreen = win => {
  if (!win) return false
  const winRect = win.rect()
  const screen = win.screen().visibleRect()
  return (
    winRect.width === screen.width &&
    winRect.height === screen.height
  )
}

S.log('[SLATE] --- Setting slate global configuration options ---')
S.configAll({
  defaultToCurrentScreen: true,
  secondsBeforeRepeat: 0.2,
  secondsBetweenRepeat: 0.1,
  keyboardLayout: 'dvorak',
  nudgePercentOf: 'screenSize',
  resizePercentOf: 'screenSize',
  modalEscapeKey: 'c:ctrl',
  windowHintsSpread: true,
})

S.log('[SLATE] --- Defining slate operations ---')
const hint = S.operation('hint', {
  characters: 'HTNSBMWV',
})
// TODO: make unhide possible for all windows
const hide = S.operation('hide', {
  app: 'all',
})
const toggle = S.operation('toggle', {
  app: 'Slack',
})
const show = S.operation('show', {
  app: 'all',
})
const full = S.operation('move', {
  x: 'screenOriginX',
  y: 'screenOriginY',
  width: 'screenSizeX',
  height: 'screenSizeY',
})
const pushRight = S.operation('push', {
  direction: 'right',
  style: 'bar-resize:screenSizeX/2',
})

const pushLeft = S.operation('push', {
  direction: 'left',
  style: 'bar-resize:screenSizeX/2',
})

const throwNextLeft = S.operation('throw', {
  width: 'screenSizeX/2',
  height: 'screenSizeY',
  screen: 'next',
})

const throwNextRight = S.operation('throw', {
  x: 'screenOriginX+(screenSizeX)/2',
  y: 'screenOriginY',
  width: 'screenSizeX/2',
  height: 'screenSizeY',
  screen: 'next',
})

const fullscreen = S.operation('move', {
  x : 'screenOriginX',
  y : 'screenOriginY',
  width : 'screenSizeX',
  height : 'screenSizeY',
})

const throwNextFullscreen = S.operation('throw', {
  x: 'screenOriginX',
  y: 'screenOriginY',
  width: 'screenSizeX',
  height: 'screenSizeY',
  screen: 'next'
})

const throwNextTop = S.operation('throw', {
  x: 'screenOriginX',
  y: 'screenOriginY',
  width: 'screenSizeX',
  height: 'screenSizeY/2',
  screen: 'next'
})

const throwNextBottom = S.operation('throw', {
  x: 'screenOriginX',
  y: 'screenOriginY + screenSizeY / 2',
  width: 'screenSizeX',
  height: 'screenSizeY/2',
  screen: 'next'
})

const throwNext = function(win) {
  if (!win) {
    return
  }
  const winRect = win.rect()
  const screen = win.screen().visibleRect()

  const newX = (winRect.x - screen.x)/screen.width+'*screenSizeX+screenOriginX'
  const newY = (winRect.y - screen.y)/screen.height+'*screenSizeY+screenOriginY'
  const newWidth = winRect.width/screen.width+'*screenSizeX'
  const newHeight = winRect.height/screen.height+'*screenSizeY'
  const throwNext = S.operation('throw', {
    x: newX,
    y: newY,
    width: newWidth,
    height: newHeight,
    screen: 'next'
  })
  win.doOperation(throwNext)
}

// S.bind('m:alt,cmd', function(win) {
//   if (!win) {
//     return
//   }
//   win.doOperation(fullscreen)
// })


// S.bind('h:ctrl', function(win) {
//   if (!win) {
//     return
//   }
//   if (pushedLeft(win)) {
//     win.doOperation(throwNextLeft)
//   } else {
//     win.doOperation(pushLeft)
//   }
// })

// S.bind('right:alt,cmd', function(win) {
//   if (!win) {
//     return
//   }
//   if (pushedRight(win)) {
//     win.doOperation(throwNextRight)
//   } else {
//     win.doOperation(pushRight)
//   }
// })

// S.bind('up:alt,cmd', function(win) {
//   if (!win) {
//     return
//   }
//   win.doOperation(throwNextTop)
// })

// S.bind('down:alt,cmd', function(win) {
//   if (!win) {
//     return
//   }
//   win.doOperation(throwNextBottom)
// })
S.log('[SLATE] --- Setting slate key bindings ---')
// S.bindAll({
  // [mod('i')]: S.op('grid'),
  // [mod('i')]: hint,
  // [mod('c')]: hide,
  // [mod('t')]: toggle,
  // [mod('s')]: show,
  // [mod('f')]: full,
  // [mod('r')]: S.op('relaunch'),
  // [mod('u')]: S.op('undo'),
  // 'h:cmd': win => {
  //   if (!win) return
  //   pushedRight(win)
  //     ? win.doOperation(full)
  //     : win.doOperation(pushLeft) 
  // },
  // 'l:cmd': win => {
  //   if (!win) return
  //   pushedLeft(win)
  //     ? win.doOperation(full)
  //     : win.doOperation(pushRight) 
  // },
  // '1:ctrl': focusLeftMonitor,
  // '2:ctrl': focusMainMonitor,
  // '3:ctrl': focusLeftMonitor,
  // '1:ctrl,shift': moveLeftMonitor,
  // '2:ctrl,shift': moveMainMonitor,
  // '3:ctrl,shift': moveLeftMonitor,
// })

for (const [i, app] of Object.entries(applications)) {
  S.bind(`${i}:ctrl`, S.op('focus', { app } ))
}
S.bind(mod('i'), hint)
// S.bind('r:ctrl,shift', S.op('relaunch'))
// S.bind('m:ctrl,shift', full)

S.log('[SLATE] --- Finished Loading config from .slate.js ---')
