#include "ppm.h"
#include <fstream>
#include <iostream>
#include <string>
using namespace std;


namespace imaging {
	//function to read float data from a .ppm file
	float * ReadPPM(const char * filename, int * w, int * h) {

		ifstream file(filename, ios::binary); //opens a stream to read a binary file

		if (!file.is_open()) {
			cerr << "File not found. " << endl;
			return nullptr;
		}

		//>> returns all characters until first space or \n
		string fileFormat; //the file format
		int width = 0; //the width of the image
		int height = 0; //the height of the image
		int intensity = 0; //the maximum allowed value per pixel
		

		file >> fileFormat; //reading the file format. must be p6
		file >> width;//reading the image width
		file >> height; //reading the image height
		file >> intensity; //reading the maximum value


		
		//checking for false formatting of the file's header
		if (fileFormat != "P6") {
			cout << "Wrong file format. Not a P6 file." << endl;
			return nullptr;
		}
		if (intensity > 255 || intensity == 0) {
			if (width == 0) {
				if (height == 0) {
					cout << "All image data are missing" << endl;
					return nullptr;
				}
				else {
					cout << "Image height is missing" << endl << "Maximum value missing, or greater than 255" << endl;
					return nullptr;
				}
			}else {
				cout << "Maximum value missing, or greater than 255" << endl;
				return nullptr;
			}
		}
		if (file.fail()) {
			cerr << "Error reading file" << endl;
			return nullptr;
		}

		//storing the width and the height of the image in
		//class Image's instances
		*w = width;
		*h = height;

		const int size = width * height * 3; //3 values per pixel

		float* data = new float[size]; //float array to be returned
		char c;
		file.get(c); //skip empty line
		for (int i = 0; i < size; i++) {
			file.get(c);
			data[i] = (float)c / (float)intensity;
		}

		cout << "Image read successfully" << endl;

		file.close();

		return data; //return float pointer

	}

	//function to write float data in a .ppm file
	bool WritePPM(const float * data, int w, int h, const char * filename) {
		ofstream file(filename, ios::binary);

		if (!file.is_open()) {
			cerr << "Could not open image file!" << endl;
			return false;
		}
		if (file.fail()) {
			cerr << "Error writing to file" << endl;
			return false;
		}
		int in = 255;
		int size = w * h * 3;
		file << "P6 \n" << w << "\n" << h << "\n" << in << "\n";

		for (int i = 0; i < size; i++) {
			file.put(data[i] * in);
		}
		cout << "Image written successfully\n";
		file.close();

		return true;
	}
}