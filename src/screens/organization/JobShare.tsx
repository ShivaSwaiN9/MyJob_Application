import React from 'react';
import {
  View,
  Text,
  Image,
  StyleSheet,
  TouchableOpacity,
  SafeAreaView,
  ScrollView,
} from 'react-native';

const JobShare = () => {
  return (
    <SafeAreaView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity style={styles.backButtonContainer}>
          <Image
            source={require('../../assets/PNG/Back.png')}
            style={styles.backButton}
          />
        </TouchableOpacity>
        <Text style={styles.headerText}>Post</Text>
      </View>

      <ScrollView style={styles.content}>
        <Text style={styles.title}>Shared a Job</Text>

        {/* Profile Section */}
        <View style={styles.profileSection}>
          <Image
            source={require('../../assets/PNG/Profile.png')}
            style={styles.profilePic}
          />
          <View style={styles.profileInfo}>
            <Text style={styles.profileName}>Orlando Diggs</Text>
            <Text style={styles.profileLocation}>California, USA</Text>
          </View>
        </View>

        {/* Description Section */}
        <View style={styles.descriptionSection}>
          <Text style={styles.descriptionTitle}>Description</Text>
          <Text style={styles.descriptionText}>
            Hey guys{'\n\n'}
            Today I am opening a job vacancy in the field of UX Designer at an Apple company. To see a job description, please see below.
          </Text>
        </View>

        {/* Job Card */}
        <View style={styles.jobCard}>
          <View style={styles.jobHeader}>
            <Image
              source={require('../../assets/PNG/google.png')}
              style={styles.companyLogo}
            />
            <View style={styles.jobInfo}>
              <Text style={styles.jobTitle}>UI/UX Designer</Text>
              <Text style={styles.jobSubtitle}>
                Job vacancies from Apple company
              </Text>
              <Text style={styles.jobLocation}>California, USA · On-site</Text>
            </View>
          </View>
          <TouchableOpacity style={styles.applicationButton}>
            <Text style={styles.applicationButtonText}>Application details</Text>
          </TouchableOpacity>
        </View>
      </ScrollView>

      <View style={styles.footer}>
        {/* Camera Icon */}
        <TouchableOpacity style={styles.iconContainer}>
          <Image
            source={require('../../assets/PNG/Camera.png')}
            style={styles.icon}
          />
        </TouchableOpacity>

        {/* Gallery Icon */}
        <TouchableOpacity style={[styles.iconContainer, styles.galleryIcon]}>
          <Image
            source={require('../../assets/PNG/picture.png')}
            style={styles.icon}
          />
        </TouchableOpacity>

        {/* Add Hashtag */}
        <TouchableOpacity style={styles.hashtagContainer}>
          <Text style={styles.hashtagText}>Add hashtag</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#EEEEEE',
  },
  backButtonContainer: {
    flex: 1,
  },
  backButton: {
    width: 24,
    height: 24,
  },
  headerText: {
    flex: 1,
    textAlign: 'right',
    fontSize: 16,
    color: '#FF6B00',
  },
  content: {
    flex: 1,
    padding: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: '600',
    marginBottom: 20,
  },
  profileSection: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 24,
  },
  profilePic: {
    width: 48,
    height: 48,
    borderRadius: 24,
    marginRight: 12,
  },
  profileInfo: {
    flex: 1,
  },
  profileName: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  profileLocation: {
    fontSize: 14,
    color: '#666666',
  },
  descriptionSection: {
    marginBottom: 24,
  },
  descriptionTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 12,
  },
  descriptionText: {
    fontSize: 14,
    lineHeight: 20,
    color: '#333333',
  },
  jobCard: {
    borderRadius: 12,
    backgroundColor: '#F8F8F8',
    padding: 16,
    marginBottom: 24,
  },
  jobHeader: {
    flexDirection: 'row',
    marginBottom: 16,
  },
  companyLogo: {
    width: 40,
    height: 40,
    marginRight: 12,
  },
  jobInfo: {
    flex: 1,
  },
  jobTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  jobSubtitle: {
    fontSize: 14,
    color: '#666666',
    marginBottom: 4,
  },
  jobLocation: {
    fontSize: 14,
    color: '#666666',
  },
  applicationButton: {
    backgroundColor: '#FFFFFF',
    borderRadius: 8,
    paddingVertical: 12,
    alignItems: 'center',
  },
  applicationButtonText: {
    fontSize: 14,
    fontWeight: '600',
    color: '#000000',
  },
  footer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: 10,
    backgroundColor: '#fff',
    borderTopLeftRadius: 15,
    borderTopRightRadius: 15,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: -2 },
    shadowOpacity: 0.1,
    shadowRadius: 5,
    elevation: 5,
  },
  iconContainer: {
    flex: 1,
    alignItems: 'center',
  },
  galleryIcon: {
    marginLeft: -20, // Adjust spacing between icons
  },
  icon: {
    width: 30,
    height: 30,
    resizeMode: 'contain',
  },
  hashtagContainer: {
    flex: 2,
    alignItems: 'flex-end',
  },
  hashtagText: {
    color: '#f37321',
    fontSize: 14,
    fontWeight: 'bold',
  },
});

export default JobShare;
