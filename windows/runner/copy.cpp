//
// Created by XJA on 2021/11/16.
//
#include "copy.h"
#include <vector>
#include <windows.h>
#include <iostream.>

namespace copy {
	int copyImage(int width, int height, const data& rgbaData) {
		constexpr int headerSize = sizeof(BITMAPINFOHEADER);
		BITMAPINFOHEADER header = { 40,width,height,1,32,0,0,0,0,0,0 };
		int dataSize = 4 * width * height;
		HGLOBAL hResult;
		if (!OpenClipboard(NULL) || !EmptyClipboard()) {
			return 1;
		}
		hResult = GlobalAlloc(GMEM_MOVEABLE, headerSize + dataSize);
		if (hResult == NULL) {
			return 1;
		}
		auto target = GlobalLock(hResult);
		ImageData imageData(width, height, (RgbaInfo*)rgbaData.data());
		memcpy(target, &header, headerSize);
		memcpy((char*)target + headerSize, imageData.data.data(), dataSize);
		GlobalUnlock(hResult);;
		if (SetClipboardData(CF_DIB, hResult) == NULL) {
			CloseClipboard();
			return 1;
		}
		CloseClipboard();
		return 0;
	}
}