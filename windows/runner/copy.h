//
// Created by XJA on 2021/11/16.
//

#ifndef QRCODE_HELPER_COPY_H
#define QRCODE_HELPER_COPY_H
#include <vector>
#include <memory>
using byte = uint8_t;
using data = std::vector<byte>;
struct RgbaInfo {
	byte red;
	byte green;
	byte blue;
	byte alpha;
};
class PointInfo {
public:
	byte blue;
	byte green;
	byte red;
	byte alpha;
	PointInfo(const RgbaInfo& rgbaInfo) :blue(rgbaInfo.blue), green(rgbaInfo.green), red(rgbaInfo.red), alpha(rgbaInfo.alpha) {}
};
class ImageData {
public:
	int width;
	int height;
	std::vector<PointInfo> data;
	ImageData(int width, int height, RgbaInfo* rgbaData) : width(width), height(height) {
		data.reserve(width * height);
		rgbaData += (height - 1) * width;
		for (int i = 0; i < height; ++i) {
			for (int j = 0; j < width; ++j) {
				data.push_back(PointInfo(*rgbaData));
				++rgbaData;
			}
			rgbaData -= (2 * width);
		}
	}
};

namespace copy {
	int copyImage(int width, int height, const data& rgbaData);
}
#endif //QRCODE_HELPER_COPY_H
