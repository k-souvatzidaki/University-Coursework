#include "Image.h"
#include "ppm.h"
#include <iostream>
#include <string>
using namespace std;

namespace imaging {

	//returns a pointer to image's data buffer
	Color* Image::getRawDataPtr() {
		return buffer;
	}

	//returns the color of pixel (x.y)
	Color Image::getPixel(unsigned int x, unsigned int y) const {
		if ((x < width) && (y < height) && (x*y > 0)) {
			return buffer[(width*y) + x];
		}
		return Color();
	}
	
	//sets the color of pixel (x,y)
	void Image::setPixel(unsigned int x, unsigned int y, Color & value) {
		if ((x > width) || (y > height) || (x*y <= 0)) {
			return;
		}
		else {
			buffer[(width*y) + x] = value;
		}
	}

	//sets the image's data buffer
	//deep copy
	void Image::setData(const Color * & data_ptr) {
		if (width <= 0 || height <= 0) {
			cout << "Width or height are not initialized" << endl;
			return;
		}
		else if (buffer == nullptr) {
			cout << "Image buffer is not allocated." << endl;
			return;
		}
		else {
			buffer = new Color[width*height];
			for (unsigned int i = 0; i < width*height; i++) {
				buffer[i] = data_ptr[i];
			}
		}
	}

	//constructors 
	//default
	Image::Image() : width(0), height(0), buffer(nullptr) {}

	//with width and height initialization 
	Image::Image(unsigned int width, unsigned int height) {
		buffer = nullptr;
		this->width = width;
		this->height = height;
	}

	//with width,height and buffer initialization
	Image::Image(unsigned int width, unsigned int height, const Color * data_ptr) {
		this->width = width;
		this->height = height;
		setData(data_ptr);
	}

	//copy constructor
	Image::Image(const Image &src) {
		width = src.getWidth();
		height = src.getHeight();
		const Color* c = ((Image)src).getRawDataPtr();
		setData(c);

	}

	//destructor
	Image::~Image() { delete[] buffer; }

	//operator
	Image & Image::operator = (const Image & right) {
		Image i = Image(right.getWidth(),right.getHeight(),((Image)right).getRawDataPtr());
		return i;
	}

	//load method
	bool Image::load(const std::string & filename, const std::string & format) {
		//check if the file is a .ppm file
		//turning everything to upper case for case insensitivity while ckecking
		string filename_toupper = filename;
		string format_toupper = format;
		for (size_t i = 0; i < filename.length(); ++i) filename_toupper.at(i) = toupper(filename[i]);
		for (size_t i = 0; i < format.length(); ++i) format_toupper.at(i) = toupper(format[i]);
		if (filename_toupper.substr(filename_toupper.length() - 4) == format_toupper) {
			cout << "Input file is a ppm format file" << endl;
		}
		else {
			cout << "Input file is not a ppm format file" << endl;
			return false;
		}

		//reading float data from .ppm file with imaging::ReadPPM
		float* data=nullptr;
		unsigned int* w = &width;
		unsigned int* h = &height;
		data = ReadPPM(filename.c_str(), (int*)w , (int*)h );
		if (data != nullptr) { //ReadPPM returns nullptr if something goes wrong while reading the image file
			buffer = new  Color[width*height];
			int j = 0;
			for (unsigned int i = 0; i < width*height; i++) {
				buffer[i] = Color(data[j], data[j + 1], data[j + 2]);
				j += 3;
			}
			delete[] data;
			return true;
		}
		else {
			cout << "Reading file unsuccessful." << endl;
			return false;
		}
		
	}

	//save method
	bool Image::save(const std::string & filename, const std::string & format) {
		//check if the file is a .ppm file
		//turning everything to upper case for case insensitivity while ckecking
		string filename_toupper = filename;
		string format_toupper = format;
		for (size_t i = 0; i < filename.length(); ++i) filename_toupper.at(i) = toupper(filename[i]);
		for (size_t i = 0; i < format.length(); ++i) format_toupper.at(i) = toupper(format[i]);
		if (filename_toupper.substr(filename_toupper.length() - 4) == format_toupper) {
			cout << "Output file is a ppm format file" << endl;
		}
		else {
			cout << "Output file is not a ppm format file. Couldn't write to file" << endl;
			return false;
		}

		//writing float data to .ppm file with imaging::WritePPM
		float* newdata=new float[width*height*3];
		int j = 0;
		for (unsigned int i = 0; i < width*height; i++) {
			newdata[j]=buffer[i].r;
			newdata[j+1] = buffer[i].g;
			newdata[j+2] = buffer[i].b;
			j += 3;
		}
		const float* newdataconst = newdata;
		bool res = WritePPM(newdataconst, width, height, filename.c_str());
		delete[] newdataconst,newdata; 
		return res;
	}
}