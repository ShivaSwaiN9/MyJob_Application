


import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Pressable,
  TextInput,
  Image,
  Alert,
  ScrollView,
} from 'react-native';
import DocumentPicker, {
  DocumentPickerResponse,
} from 'react-native-document-picker';

const UploadCV = ({ route, navigation }: any) => {
  const { job } = route.params;
  const [selectedCV, setSelectedCV] = useState<DocumentPickerResponse | null>(
    null,
  );
  const [isApplicationSubmitted, setIsApplicationSubmitted] = useState(false);

  const pickDocument = async () => {
    try {
      const result = await DocumentPicker.pick({
        type: [DocumentPicker.types.pdf],
      });
      setSelectedCV(result[0]);
    } catch (err) {
      if (DocumentPicker.isCancel(err)) {
        // User cancelled the picker
      } else {
        Alert.alert('Error', 'An error occurred while picking the document');
      }
    }
  };

  const handleApplyNow = () => {
    if (selectedCV) {
      setIsApplicationSubmitted(true);
    } else {
      Alert.alert('Error', 'Please upload your CV before applying');
    }
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header Section */}
      <View style={styles.header}>
        <Pressable
          style={styles.backButton}
          onPress={() => navigation.goBack()}>
          <Text style={styles.backText}></Text>
          {/* ← */}
        </Pressable>
        <Image source={job.logo} style={styles.logo} />
        <Pressable>
          <Text style={styles.menuIcon}></Text>
          {/* ⋮ */}
        </Pressable>
      </View>

       {/* Job Details Section */}
       <View style={styles.detailsContainer}>
            <Text style={styles.jobTitle}>{job.title}</Text>
            <View style={styles.jobDetails}>
              <Text style={styles.detailText}>{job.company}</Text>
              <Text style={styles.separator}>•</Text>
              <Text style={styles.detailText}>{job.location}</Text>
              <Text style={styles.separator}>•</Text>
              <Text style={styles.detailText}>{job.postedTime}</Text>
            </View>
          </View>

      {!isApplicationSubmitted ? (
        <>
         

          {/* Upload CV Section */}
          <View style={styles.uploadContainer}>
            <Text style={styles.sectionTitle}>Upload CV</Text>
            <Text style={styles.uploadDescription}>
              Add your CV/Resume to apply for a job (PDF only)
            </Text>
            {!selectedCV ? (
              <Pressable style={styles.uploadButton} onPress={pickDocument}>
                <Image
                  source={require('../../assets/PNG/Upload.png')}
                  style={styles.uploadIcon}
                />
                <Text style={styles.uploadButtonText}>Upload CV/Resume (PDF)</Text>
              </Pressable>
            ) : (
              <View style={styles.fileContainer}>
                <View style={styles.fileDetails}>
                  <Image
                    source={require('../../assets/PNG/PDF.png')}
                    style={styles.fileIcon}
                  />
                  <View>
                    <Text style={styles.fileName}>
                      {selectedCV.name || 'Unknown file'}
                    </Text>
                    <Text style={styles.fileInfo}>
                      {selectedCV.size
                        ? `${Math.round(selectedCV.size / 1024)} Kb`
                        : 'Unknown size'}{' '}
                      • {new Date().toLocaleDateString()} at{' '}
                      {new Date().toLocaleTimeString([], {
                        hour: '2-digit',
                        minute: '2-digit',
                      })}
                    </Text>
                  </View>
                </View>
                <Pressable
                  onPress={() => setSelectedCV(null)}
                  style={styles.removeFileButton}>
                  <Text style={styles.removeFileText}>Remove file</Text>
                </Pressable>
              </View>
            )}
          </View>

          {/* Information Section */}
          <View style={styles.informationContainer}>
            <Text style={styles.sectionTitle}>Information</Text>
            <TextInput
              style={styles.textArea}
              placeholder="Explain why you are the right person for this job"
              placeholderTextColor="#A9A9A9"
              multiline={true}
              numberOfLines={5}
            />
          </View>

          {/* Apply Now Button */}
          <Pressable style={styles.applyButton} onPress={handleApplyNow}>
            <Text style={styles.applyButtonText}>APPLY NOW</Text>
          </Pressable>
        </>
      ) : (
        <>
          {/* Success Message */}
          <View style={styles.successContainer}>
            <Image
              source={require('../../assets/PNG/illustration.png')}
              style={styles.successIcon}
            />
            <Text style={styles.successText}>Successful</Text>
            <Text style={styles.successSubText}>
              Congratulations, your application has been sent
            </Text>
          </View>

          {/* Footer Buttons */}
          <View style={styles.footerButtons}>
            <Pressable style={styles.secondaryButton}>
              <Text style={styles.secondaryButtonText}>FIND A SIMILAR JOB</Text>
            </Pressable>
            <Pressable
              style={styles.primaryButton}
              onPress={() => navigation.navigate('HomeScreen')}>
              <Text style={styles.primaryButtonText}>BACK TO HOME</Text>
            </Pressable>
          </View>
        </>
      )}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FD',
    paddingHorizontal: 16,
    paddingTop: 10,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 20,
  },
  backButton: {
    padding: 8,
  },
  backText: {
    fontSize: 18,
    color: '#4C4C4C',
  },
  logo: {
    width: 60,
    height: 60,
    resizeMode: 'contain',
  },
  menuIcon: {
    fontSize: 22,
    color: '#4C4C4C',
  },
  detailsContainer: {
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#F9FAFB',
    borderBottomWidth: 1,
    borderBottomColor: '#E5E7EB',
    marginBottom:20,
  },
  jobTitle: {
    fontSize: 22,
    fontWeight: '600',
    color: '#0B053D',
  },
  jobDetails: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 8,
  },
  detailText: {
    fontSize: 14,
    color: '#4C4C4C',
  },
  separator: {
    marginHorizontal: 8,
    fontSize: 14,
    color: '#4C4C4C',
  },
  uploadContainer: {
    marginBottom: 20,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#0B053D',
    marginBottom: 8,
  },
  uploadDescription: {
    fontSize: 14,
    color: '#4C4C4C',
    marginBottom: 16,
  },
  uploadButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 50,
    borderWidth: 1,
    borderColor: '#D1D1D1',
    borderRadius: 10,
    backgroundColor: '#F8F9FD',
  },
  uploadIcon: {
    width: 20,
    height: 20,
    resizeMode: 'contain',
    marginRight: 8,
  },
  uploadButtonText: {
    fontSize: 16,
    color: '#0B053D',
    fontWeight: '500',
  },
  fileContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 10,
    borderRadius: 8,
    backgroundColor: '#F1F4FF',
    marginTop: 10,
  },
  fileDetails: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  fileIcon: {
    width: 32,
    height: 32,
    marginRight: 10,
  },
  fileName: {
    fontSize: 14,
    fontWeight: '600',
    color: '#0B053D',
  },
  fileInfo: {
    fontSize: 12,
    color: '#4C4C4C',
  },
  removeFileButton: {
    padding: 8,
  },
  removeFileText: {
    fontSize: 14,
    color: '#FF4B4B',
    fontWeight: '500',
  },
  informationContainer: {
    marginBottom: 20,
  },
  textArea: {
    borderWidth: 1,
    borderColor: '#D1D1D1',
    borderRadius: 10,
    backgroundColor: '#FFFFFF',
    paddingHorizontal: 20, 
    paddingVertical: 20,  
    textAlignVertical: 'top',
    color: '#4C4C4C',
    fontSize: 14,
    minHeight: 250,
  },
  applyButton: {
    backgroundColor: '#0B053D',
    paddingVertical: 14,
    borderRadius: 10,
    alignItems: 'center',
    marginBottom: 20,
  },
  applyButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#FFFFFF',
  },
  successContainer: {
    alignItems: 'center',
    padding: 32,
  },
  successIcon: {
    width: 120,
    height: 120,
    marginBottom: 24,
  },
  successText: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  successSubText: {
    fontSize: 16,
    color: '#666666',
    textAlign: 'center',
  },
  footerButtons: {
    flexDirection: 'column',
    marginTop: 20,
  },
  secondaryButton: {
    backgroundColor: '#EFEFFF',
    paddingVertical: 14,
    borderRadius: 10,
    marginBottom: 10,
    alignItems: 'center',
  },
  secondaryButtonText: {
    fontSize: 16,
    color: '#7F7FFF',
  },
  primaryButton: {
    backgroundColor: '#0B053D',
    paddingVertical: 14,
    borderRadius: 10,
    alignItems: 'center',
  },
  primaryButtonText: {
    fontSize: 16,
    color: '#FFFFFF',
  },
});

export default UploadCV;

