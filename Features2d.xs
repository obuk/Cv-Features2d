/* -*- mode: text; coding: utf-8; tab-width: 4 -*- */

#include "Cv.inc"

#if _CV_VERSION() >= _VERSION(2,4,0)
#  include "opencv2/nonfree/nonfree.hpp"
#endif

typedef vector<Mat> MatV;
typedef vector<KeyPoint> KeyPointV;
typedef vector<DMatch> DMatchV;
typedef vector<vector<DMatch> > DMatchVV;

static CvMat* matToCvmat(Mat& var)
{
#if 0
	CvMat* cvmat = cvCreateMatHeader(var.rows, var.cols, var.type());
	cvSetData(cvmat, var.data, CV_AUTOSTEP);
	cvIncRefData(cvmat);	   // XXXXX
	return cvmat;
#else
	CvMat cvmat = var;
	return cvCloneMat(&cvmat);
#endif
}


MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::FeatureDetector

FeatureDetector*
create(const char* CLASS, const char* detectorType)
INIT:
	Perl_croak(aTHX_ "TBD: %s::create(\"%s\")\n", CLASS, detectorType);
CODE:
	RETVAL = FeatureDetector::create(detectorType);
OUTPUT:
	RETVAL

KeyPointV
FeatureDetector::detect(CvArr* image, CvArr* mask = NULL)
CODE:
	if (mask) {
		THIS->detect(cvarrToMat(image), RETVAL, cvarrToMat(mask));
	} else {
		THIS->detect(cvarrToMat(image), RETVAL);
	}
OUTPUT:
	RETVAL


MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::FastFeatureDetector

FastFeatureDetector*
FastFeatureDetector::new(int threshold=1, bool nonmaxSuppression=true)

void
FastFeatureDetector::DESTROY()


MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::StarFeatureDetector

StarFeatureDetector*
StarFeatureDetector::new(int maxSize=16, int responseThreshold=30, int lineThresholdProjected = 10, int lineThresholdBinarized=8, int suppressNonmaxSize=5)

void
StarFeatureDetector::DESTROY()


#if _CV_VERSION() >= _VERSION(2,4,0)

MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::SIFT

SIFT*
SIFT::new(int nfeatures=0, int nOctaveLayers=3, double contrastThreshold=0.04, double edgeThreshold=10, double sigma=1.6)

void
SIFT::DESTROY()

#endif

MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::SURF

SURF*
SURF::new(double hessianThreshold, int nOctaves=4, int nOctaveLayers=2, bool extended=true, bool upright=false)

void
SURF::DESTROY()


#if _CV_VERSION() >= _VERSION(2,4,0)

MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::ORB

ORB*
ORB::new(int nfeatures=500, float scaleFactor=1.2f, int nlevels=8, int edgeThreshold=31, int firstLevel=0, int WTA_K=2, int scoreType=ORB::HARRIS_SCORE, int patchSize=31)

void
ORB::DESTROY()

#endif

#if _CV_VERSION() >= _VERSION(2,4,0)

MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::BRISK

BRISK*
BRISK::new(int thresh=30, int octaves=3, float patternScale=1.0f)

void
BRISK::DESTROY()

#endif

MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::GoodFeaturesToTrackDetector

GoodFeaturesToTrackDetector*
GoodFeaturesToTrackDetector::new(int maxCorners=1000, double qualityLevel=0.01, double minDistance=1., int blockSize=3, bool useHarrisDetector=false, double k=0.04 )

void
GoodFeaturesToTrackDetector::DESTROY()


MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::MserFeatureDetector

MserFeatureDetector*
MserFeatureDetector::new(int delta, int minArea, int maxArea, double maxVariation, double minDiversity, int maxEvolution, double areaThreshold, double minMargin, int edgeBlurSize)

void
MserFeatureDetector::DESTROY()


#if _CV_VERSION() >= _VERSION(2,4,0)

MODULE = Cv::Features2d		PACKAGE = Cv::Features2d::DenseFeatureDetector

DenseFeatureDetector*
DenseFeatureDetector::new(float initFeatureScale=1.f, int featureScaleLevels=1, float featureScaleMul=0.1f, int initXyStep=6, int initImgBound=0, bool varyXyStepWithScale=true, bool varyImgBoundWithScale=false)

void
DenseFeatureDetector::DESTROY()

#endif

MODULE = Cv::Features2d		PACKAGE = Cv::Features2d

# C++: void drawKeypoints(const Mat& image, const vector<KeyPoint>& keypoints, Mat& outImage, const Scalar& color=Scalar::all(-1), int flags=DrawMatchesFlags::DEFAULT )

CvMat*
drawKeypoints(CvArr* image, KeyPointV keypoints, CvScalar color = cvScalarAll(-1), int flags=DrawMatchesFlags::DEFAULT)
CODE:
	Mat outImage;
	drawKeypoints(cvarrToMat(image), keypoints, outImage, color, flags);
	RETVAL = matToCvmat(outImage);
OUTPUT:
	RETVAL
