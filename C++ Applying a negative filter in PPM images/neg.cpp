#include <cstdlib>
#include <iostream>
#include <string>
#include "ppm.h"
#include "Image.h"
using namespace imaging;
using namespace std;


//main app
int main(int argc, char* argv[]) {

	Image img=Image();
	string file;
	if (argv[1]==NULL) {
		cout << "Please enter the file name" << endl;
		cin >> file;
	}
	else {
		file = argv[1];
	}

	if(file.length() > 4) { 
		string format = ".PPM";
		bool a= img.load(file, format);
		if (a == true) {

			cout << "Height= " << img.getHeight() << endl;
			cout << "Width= " << img.getWidth() << endl;


			Color  c = Color(1, 1, 1);
			Color temp,temp2;
			for (int i = 0; i < img.getWidth(); i++) {
				for (int j = 0; j < img.getHeight(); j++) {
					temp = img.getPixel(i, j);
					temp2 = c - temp;
					img.setPixel(i, j, temp2);
				}

			}

			string fileneg = file.replace(file.length() - 4, 4, "_neg.ppm");;
			img.save(fileneg, format);
			cout << "Negative file: " << fileneg << endl;
		}else {
			cout << "Operation on file " << file << " could not be completed." << endl;
		}
	}
	else { cout << "Input file is not a ppm format file" << endl; }
	

	system("pause");
	return 0;
}