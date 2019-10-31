// Define standard screen positions
var standardPositions = {
  fullScreen: { key: ctrl('pad5') },

  // Corners
  topLeftCorner: { 
    key: ctrl('pad7'),
    width: 1 / 2,
    height: 1 / 2,
  },
  topRightCorner: {
    key: ctrl('pad9'),
    hPosition: 1,
    width: 1 / 2,
    height: 1 / 2,
  },
  bottomLeftCorner: {
    key: ctrl('pad1'),
    vPosition: 1,
    width: 1 / 2,
    height: 1 / 2,
  },
  bottomRightCorner: {
    key: ctrl('pad3'),
    hPosition: 1,
    vPosition: 1,
    width: 1 / 2,
    height: 1 / 2,
  },

  // Halves
  leftHalf: {
    key: ctrl('pad4'),
    width: 1 / 2,
  },
  rightHalf: {
    key: ctrl('pad6'),
    width: 1 / 2,
    hPosition: 1,
  },
  topHalf: {
    key: ctrl('pad8'),
    height: 1 / 2,
  },
  bottomHalf: {
    key: ctrl('pad2'),
    height: 1 / 2,
    vPosition: 1,
  },

  // 2/3 of Screen
  bottomTwoThirds: {
    key: alt('pad0'),
    height: 2 / 3,
    offsetY: 1 / 3,
  },
  leftTwoThirds: {
    key: alt('pad1'),
    width: 2 / 3,
  },
  rightTwoThirds: {
    key: alt('pad2'),
    width: 2 / 3,
    offsetX: 1 / 3,
  },
  topTwoThirds: {
    key: alt('pad3'),
    height: 2 / 3,
  },

  // 1/3 Horizontal
  leftOneThird: {
    key: alt('pad4'),
    width: 1 / 3,
  },
  middleOneThird: {
    key: alt('pad5'),
    width: 1 / 3,
    hPosition: 1,
  },
  rightOneThird: {
    key: alt('pad6'),
    width: 1 / 3,
    hPosition: 2,
  },
  leftOneThirdTopHalf: {
    width: 1 / 3,
    height: 1 / 2,
  },
  middleOneThirdTopHalf: {
    width: 1 / 3,
    height: 1 / 2,
    hPosition: 1,
  },
  rightOneThirdTopHalf: {
    width: 1 / 3,
    height: 1 / 2,
    hPosition: 2,
  },

  // 1/3 Vertical
  topOneThird: {
    key: alt('pad7'),
    height: 1 / 3,
  },
  middleOneThirdVertical: {
    key: alt('pad8'),
    height: 1 / 3,
    vPosition: 1,
  },
  bottomOneThird: {
    key: alt('pad9'),
    height: 1 / 3,
    vPosition: 2,
  },
  leftOneThirdBottomHalf: {
    width: 1 / 3,
    height: 1 / 2,
    vPosition: 1,
  },
  middleOneThirdBottomHalf: {
    width: 1 / 3,
    height: 1 / 2,
    hPosition: 1,
    vPosition: 1,
  },
  rightOneThirdBottomHalf: {
    width: 1 / 3,
    height: 1 / 2,
    hPosition: 2,
    vPosition: 1,
  },

  leftOneHalfByOneThird: {
    width: 1 / 2,
    height: 1 / 3,
  },
  rightOneHalfByOneThird: {
    width: 1 / 2,
    height: 1 / 3,
    hPosition: 1,
  },

  // 1/4 of screen
  firstOneFourth: {
    key: sc3('pad='),
    height: 1 / 4,
  },
  secondOneFourth: {
    key: sc3('pad8'),
    height: 1 / 4,
    vPosition: 1,
  },
  thirdOneFourth: {
    key: sc3('pad5'),
    height: 1 / 4,
    vPosition: 2,
  },
  fourthOneFourth: {
    key: sc3('pad2'),
    height: 1 / 4,
    vPosition: 3,
  },

  // 1/5 of screen vertical
  firstOneFifth: {
    key: sc3('pad/'),
    height: 1 / 5,
  },
  secondOneFifth: {
    key: sc3('pad9'),
    height: 1 / 5,
    vPosition: 1,
  },
  thirdOneFifth: {
    key: sc3('pad6'),
    height: 1 / 5,
    vPosition: 2,
  },
  fourthOneFifth: {
    key: sc3('pad3'),
    height: 1 / 5,
    vPosition: 3,
  },
  fifthOneFifth: {
    key: sc3('pad.'),
    height: 1 / 5,
    vPosition: 4,
  }
};
BindScreenPositions(standardPositions, screens);
