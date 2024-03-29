;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit CaptureModule : 
  module SinglePortRam : 
    input clock : Clock
    input reset : Reset
    output io : {flip addr : UInt<17>, flip dataIn : UInt<16>, dataOut : UInt<16>, flip wrEna : UInt<1>, flip rdEna : UInt<1>}
    
    smem mem : UInt<16>[102080], undefined @[SinglePortedRam.scala 16:24]
    when io.wrEna : @[SinglePortedRam.scala 17:18]
      write mport MPORT = mem[io.addr], clock
      MPORT <= io.dataIn
      skip @[SinglePortedRam.scala 17:18]
    wire _io_dataOut_WIRE : UInt @[SinglePortedRam.scala 20:25]
    _io_dataOut_WIRE is invalid @[SinglePortedRam.scala 20:25]
    when io.rdEna : @[SinglePortedRam.scala 20:25]
      _io_dataOut_WIRE <= io.addr @[SinglePortedRam.scala 20:25]
      node _io_dataOut_T = or(_io_dataOut_WIRE, UInt<17>("h00")) @[SinglePortedRam.scala 20:25]
      node _io_dataOut_T_1 = bits(_io_dataOut_T, 16, 0) @[SinglePortedRam.scala 20:25]
      read mport io_dataOut_MPORT = mem[_io_dataOut_T_1], clock @[SinglePortedRam.scala 20:25]
      skip @[SinglePortedRam.scala 20:25]
    io.dataOut <= io_dataOut_MPORT @[SinglePortedRam.scala 20:14]
    
  module CaptureModule : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip pclk : UInt<1>, flip href : UInt<1>, flip vsync : UInt<1>, flip pixelIn : UInt<8>, pixelOut : UInt<16>, pixelAddr : UInt<17>, frameWidth : UInt<10>, frameHeight : UInt<9>, flip capture : UInt<1>, flip videoMode : UInt<1>, capturing : UInt<1>, flip readFrame : UInt<1>, pixelValid : UInt<1>, frameFull : UInt<1>, newFrame : UInt<1>}
    
    reg FMS : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[CaptureModule.scala 52:20]
    reg writePtr : UInt<17>, clock with : (reset => (reset, UInt<17>("h00"))) @[CaptureModule.scala 54:27]
    reg readPtr : UInt<17>, clock with : (reset => (reset, UInt<17>("h00"))) @[CaptureModule.scala 55:27]
    reg firstByte : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[CaptureModule.scala 56:27]
    reg secondByte : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[CaptureModule.scala 57:27]
    node pixel = cat(firstByte, secondByte) @[Cat.scala 30:58]
    reg captureSignalHolder : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[CaptureModule.scala 62:36]
    reg bufferDepthCounter : UInt<17>, clock with : (reset => (reset, UInt<17>("h00"))) @[CaptureModule.scala 64:36]
    reg newFrame : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[CaptureModule.scala 65:36]
    reg pixelIndex : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[CaptureModule.scala 66:36]
    reg rowCnt : UInt<9>, clock with : (reset => (reset, UInt<9>("h00"))) @[CaptureModule.scala 67:36]
    reg colCnt : UInt<10>, clock with : (reset => (reset, UInt<10>("h00"))) @[CaptureModule.scala 68:36]
    reg frameFull : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[CaptureModule.scala 69:36]
    reg bufferOverflow : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[CaptureModule.scala 70:36]
    wire capturing : UInt<1>
    capturing <= UInt<1>("h00")
    wire bufferAddr : UInt<17>
    bufferAddr <= UInt<17>("h00")
    wire wrEnaWire : UInt<1>
    wrEnaWire <= UInt<1>("h00")
    reg wrEna : UInt<1>, clock @[CaptureModule.scala 75:28]
    wrEna <= wrEnaWire @[CaptureModule.scala 75:28]
    reg pixelValid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[CaptureModule.scala 76:28]
    inst buffer of SinglePortRam @[CaptureModule.scala 78:22]
    buffer.clock <= clock
    buffer.reset <= reset
    node _vsyncFallingEdge_T = eq(io.vsync, UInt<1>("h00")) @[CaptureModule.scala 80:27]
    reg vsyncFallingEdge_REG : UInt<1>, clock @[CaptureModule.scala 80:50]
    vsyncFallingEdge_REG <= io.vsync @[CaptureModule.scala 80:50]
    node vsyncFallingEdge = and(_vsyncFallingEdge_T, vsyncFallingEdge_REG) @[CaptureModule.scala 80:38]
    node _hrefFallingEdge_T = eq(io.href, UInt<1>("h00")) @[CaptureModule.scala 81:27]
    reg hrefFallingEdge_REG : UInt<1>, clock @[CaptureModule.scala 81:50]
    hrefFallingEdge_REG <= io.href @[CaptureModule.scala 81:50]
    node hrefFallingEdge = and(_hrefFallingEdge_T, hrefFallingEdge_REG) @[CaptureModule.scala 81:38]
    reg hrefRisingEdge_REG : UInt<1>, clock @[CaptureModule.scala 82:50]
    hrefRisingEdge_REG <= io.href @[CaptureModule.scala 82:50]
    node _hrefRisingEdge_T = eq(hrefRisingEdge_REG, UInt<1>("h00")) @[CaptureModule.scala 82:42]
    node hrefRisingEdge = and(io.href, _hrefRisingEdge_T) @[CaptureModule.scala 82:38]
    reg pclkRisingEdge_REG : UInt<1>, clock @[CaptureModule.scala 83:50]
    pclkRisingEdge_REG <= io.pclk @[CaptureModule.scala 83:50]
    node _pclkRisingEdge_T = eq(pclkRisingEdge_REG, UInt<1>("h00")) @[CaptureModule.scala 83:42]
    node pclkRisingEdge = and(io.pclk, _pclkRisingEdge_T) @[CaptureModule.scala 83:38]
    node _T = or(io.videoMode, io.readFrame) @[CaptureModule.scala 86:23]
    node _T_1 = and(_T, frameFull) @[CaptureModule.scala 86:40]
    when _T_1 : @[CaptureModule.scala 86:55]
      node _T_2 = eq(io.href, UInt<1>("h00")) @[CaptureModule.scala 87:24]
      node _T_3 = and(capturing, _T_2) @[CaptureModule.scala 87:20]
      when _T_3 : @[CaptureModule.scala 87:34]
        bufferAddr <= readPtr @[CaptureModule.scala 88:18]
        node _readPtr_T = add(readPtr, UInt<1>("h01")) @[CaptureModule.scala 89:29]
        node _readPtr_T_1 = tail(_readPtr_T, 1) @[CaptureModule.scala 89:29]
        readPtr <= _readPtr_T_1 @[CaptureModule.scala 89:18]
        pixelValid <= UInt<1>("h01") @[CaptureModule.scala 90:18]
        skip @[CaptureModule.scala 87:34]
      else : @[CaptureModule.scala 91:28]
        node _T_4 = eq(capturing, UInt<1>("h00")) @[CaptureModule.scala 91:17]
        when _T_4 : @[CaptureModule.scala 91:28]
          bufferAddr <= readPtr @[CaptureModule.scala 92:18]
          node _readPtr_T_2 = add(readPtr, UInt<1>("h01")) @[CaptureModule.scala 93:29]
          node _readPtr_T_3 = tail(_readPtr_T_2, 1) @[CaptureModule.scala 93:29]
          readPtr <= _readPtr_T_3 @[CaptureModule.scala 93:18]
          pixelValid <= UInt<1>("h01") @[CaptureModule.scala 94:18]
          skip @[CaptureModule.scala 91:28]
        else : @[CaptureModule.scala 95:16]
          pixelValid <= UInt<1>("h00") @[CaptureModule.scala 96:18]
          skip @[CaptureModule.scala 95:16]
      node _T_5 = eq(readPtr, bufferDepthCounter) @[CaptureModule.scala 98:18]
      when _T_5 : @[CaptureModule.scala 98:42]
        readPtr <= UInt<1>("h00") @[CaptureModule.scala 99:26]
        bufferDepthCounter <= UInt<1>("h00") @[CaptureModule.scala 100:26]
        frameFull <= UInt<1>("h00") @[CaptureModule.scala 101:26]
        pixelValid <= UInt<1>("h00") @[CaptureModule.scala 102:26]
        skip @[CaptureModule.scala 98:42]
      skip @[CaptureModule.scala 86:55]
    else : @[CaptureModule.scala 104:15]
      reg bufferAddr_REG : UInt, clock @[CaptureModule.scala 105:26]
      bufferAddr_REG <= writePtr @[CaptureModule.scala 105:26]
      bufferAddr <= bufferAddr_REG @[CaptureModule.scala 105:16]
      skip @[CaptureModule.scala 104:15]
    node _captureSignalHolder_T = mux(io.capture, io.capture, captureSignalHolder) @[CaptureModule.scala 108:30]
    captureSignalHolder <= _captureSignalHolder_T @[CaptureModule.scala 108:24]
    node _T_6 = eq(UInt<1>("h00"), FMS) @[Conditional.scala 37:30]
    when _T_6 : @[Conditional.scala 40:58]
      when io.vsync : @[CaptureModule.scala 112:22]
        FMS <= UInt<1>("h00") @[CaptureModule.scala 113:13]
        skip @[CaptureModule.scala 112:22]
      else : @[CaptureModule.scala 114:9]
        node _T_7 = or(captureSignalHolder, io.videoMode) @[CaptureModule.scala 115:34]
        when _T_7 : @[CaptureModule.scala 115:50]
          when vsyncFallingEdge : @[CaptureModule.scala 116:34]
            FMS <= UInt<1>("h01") @[CaptureModule.scala 117:33]
            captureSignalHolder <= UInt<1>("h00") @[CaptureModule.scala 118:33]
            newFrame <= UInt<1>("h00") @[CaptureModule.scala 119:33]
            rowCnt <= UInt<1>("h00") @[CaptureModule.scala 120:33]
            colCnt <= UInt<1>("h00") @[CaptureModule.scala 121:33]
            writePtr <= UInt<1>("h00") @[CaptureModule.scala 122:33]
            skip @[CaptureModule.scala 116:34]
          skip @[CaptureModule.scala 115:50]
        skip @[CaptureModule.scala 114:9]
      capturing <= UInt<1>("h00") @[CaptureModule.scala 126:17]
      skip @[Conditional.scala 40:58]
    else : @[Conditional.scala 39:67]
      node _T_8 = eq(UInt<1>("h01"), FMS) @[Conditional.scala 37:30]
      when _T_8 : @[Conditional.scala 39:67]
        capturing <= UInt<1>("h01") @[CaptureModule.scala 129:17]
        node _newFrame_T = mux(io.vsync, UInt<1>("h01"), UInt<1>("h00")) @[CaptureModule.scala 130:23]
        newFrame <= _newFrame_T @[CaptureModule.scala 130:17]
        node _FMS_T = mux(io.vsync, UInt<1>("h00"), UInt<1>("h01")) @[CaptureModule.scala 131:23]
        FMS <= _FMS_T @[CaptureModule.scala 131:17]
        node _T_9 = and(io.href, pclkRisingEdge) @[CaptureModule.scala 133:20]
        when _T_9 : @[CaptureModule.scala 133:39]
          node _pixelIndex_T = eq(pixelIndex, UInt<1>("h00")) @[CaptureModule.scala 135:25]
          pixelIndex <= _pixelIndex_T @[CaptureModule.scala 135:22]
          node _T_10 = eq(UInt<1>("h00"), pixelIndex) @[Conditional.scala 37:30]
          when _T_10 : @[Conditional.scala 40:58]
            firstByte <= io.pixelIn @[CaptureModule.scala 138:25]
            skip @[Conditional.scala 40:58]
          else : @[Conditional.scala 39:67]
            node _T_11 = eq(UInt<1>("h01"), pixelIndex) @[Conditional.scala 37:30]
            when _T_11 : @[Conditional.scala 39:67]
              secondByte <= io.pixelIn @[CaptureModule.scala 141:26]
              wrEnaWire <= pclkRisingEdge @[CaptureModule.scala 142:25]
              skip @[Conditional.scala 39:67]
          skip @[CaptureModule.scala 133:39]
        when wrEnaWire : @[CaptureModule.scala 182:22]
          node _colCnt_T = add(colCnt, UInt<1>("h01")) @[CaptureModule.scala 183:30]
          node _colCnt_T_1 = tail(_colCnt_T, 1) @[CaptureModule.scala 183:30]
          colCnt <= _colCnt_T_1 @[CaptureModule.scala 183:20]
          node _writePtr_T = add(writePtr, UInt<1>("h01")) @[CaptureModule.scala 184:32]
          node _writePtr_T_1 = tail(_writePtr_T, 1) @[CaptureModule.scala 184:32]
          writePtr <= _writePtr_T_1 @[CaptureModule.scala 184:20]
          skip @[CaptureModule.scala 182:22]
        when hrefRisingEdge : @[CaptureModule.scala 186:27]
          node _rowCnt_T = add(rowCnt, UInt<1>("h01")) @[CaptureModule.scala 187:26]
          node _rowCnt_T_1 = tail(_rowCnt_T, 1) @[CaptureModule.scala 187:26]
          rowCnt <= _rowCnt_T_1 @[CaptureModule.scala 187:16]
          colCnt <= UInt<1>("h00") @[CaptureModule.scala 188:16]
          skip @[CaptureModule.scala 186:27]
        skip @[Conditional.scala 39:67]
    when newFrame : @[CaptureModule.scala 192:18]
      bufferDepthCounter <= writePtr @[CaptureModule.scala 193:24]
      skip @[CaptureModule.scala 192:18]
    reg REG : UInt<1>, clock @[CaptureModule.scala 195:28]
    REG <= newFrame @[CaptureModule.scala 195:28]
    node _T_12 = eq(REG, UInt<1>("h00")) @[CaptureModule.scala 195:20]
    node _T_13 = and(newFrame, _T_12) @[CaptureModule.scala 195:17]
    when _T_13 : @[CaptureModule.scala 195:40]
      frameFull <= UInt<1>("h01") @[CaptureModule.scala 196:24]
      skip @[CaptureModule.scala 195:40]
    buffer.io.wrEna <= wrEna @[CaptureModule.scala 199:21]
    buffer.io.rdEna <= io.readFrame @[CaptureModule.scala 200:21]
    buffer.io.addr <= bufferAddr @[CaptureModule.scala 201:21]
    buffer.io.dataIn <= pixel @[CaptureModule.scala 202:21]
    io.capturing <= capturing @[CaptureModule.scala 205:21]
    io.frameWidth <= colCnt @[CaptureModule.scala 206:21]
    io.frameHeight <= rowCnt @[CaptureModule.scala 207:21]
    reg io_pixelAddr_REG : UInt, clock @[CaptureModule.scala 208:31]
    io_pixelAddr_REG <= readPtr @[CaptureModule.scala 208:31]
    io.pixelAddr <= io_pixelAddr_REG @[CaptureModule.scala 208:21]
    io.pixelOut <= buffer.io.dataOut @[CaptureModule.scala 209:21]
    io.newFrame <= newFrame @[CaptureModule.scala 210:21]
    io.frameFull <= frameFull @[CaptureModule.scala 211:21]
    io.pixelValid <= pixelValid @[CaptureModule.scala 212:21]
    
