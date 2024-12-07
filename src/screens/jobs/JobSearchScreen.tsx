import React from 'react';
import {
  View,
  TextInput,
  StyleSheet,
  Image,
  Pressable,
  Text,
  ScrollView,
  ImageBackground,
  KeyboardAvoidingView,
  Platform,
} from 'react-native';

const jobData = [
  {
    id: 1,
    logo: require('../../assets/PNG/google.png'),
    title: 'UI/UX Designer',
    company: 'Google Inc',
    location: 'California, USA',
    tags: ['Design', 'Full time', 'Senior designer'],
    salary: '$15K/Mo',
  },
  {
    id: 2,
    logo: require('../../assets/PNG/dribble.png'),
    title: 'Lead Designer',
    company: 'Dribble Inc',
    location: 'California, USA',
    tags: ['Design', 'Full time', 'Senior designer'],
    salary: '$20K/Mo',
  },
];

const JobCard: React.FC<{ job: any }> = ({ job }) => {
  return (
    <View style={styles.jobCard}>
      <Image source={job.logo} style={styles.jobLogo} />
      <View style={styles.jobInfo}>
        <Text style={styles.jobTitle}>{job.title}</Text>
        <Text style={styles.companyInfo}>
          {job.company} · {job.location}
        </Text>
        <View style={styles.tagsRow}>
          {job.tags.map((tag: string, index: number) => (
            <Text key={index} style={styles.tag}>
              {tag}
            </Text>
          ))}
        </View>
      </View>
      <Text style={styles.salary}>{job.salary}</Text>
    </View>
  );
};

const JobSearchScreen: React.FC = ({ navigation }: any) => {
  return (
    <KeyboardAvoidingView 
      behavior={Platform.OS === "ios" ? "padding" : "height"}
      style={styles.container}
    >
      <ScrollView style={styles.contentScrollView}>
        {/* Header Section */}
        <ImageBackground source={require('../../assets/PNG/Background.png')} style={styles.header}>
          <View style={styles.inputsOverlay}>
            <Pressable onPress={() => navigation.goBack()} style={styles.backButton}>
              <Image source={require('../../assets/PNG/Back.png')} />
            </Pressable>
            <View style={styles.searchContainer}>
              <View style={styles.inputContainer}>
                <Image
                  source={require('../../assets/PNG/search_12192414.png')}
                  style={styles.icon}
                />
                <TextInput placeholder="Design" placeholderTextColor="#ccc" style={styles.textInput} />
              </View>
              <View style={styles.inputContainer}>
                <Image source={require('../../assets/PNG/Location.png')} style={styles.icon} />
                <TextInput
                  placeholder="California, USA"
                  placeholderTextColor="#ccc"
                  style={styles.textInput}
                />
              </View>
            </View>
          </View>
        </ImageBackground>

        {/* Content Section */}
        <View style={styles.content}>
          <View style={styles.filterContainer}>
            <Pressable
              style={styles.iconButton}
              onPress={() => navigation.navigate('Specialization')}
            >
              <Image source={require('../../assets/PNG/Iconfilter.png')} style={styles.iconImage} />
            </Pressable>
            <ScrollView
              horizontal={true}
              showsHorizontalScrollIndicator={false}
              contentContainerStyle={styles.scrollContainer}
            >
              {['Senior Designer', 'Junior Developer', 'Product Manager', 'UI/UX Specialist'].map(
                (text, index) => (
                  <Pressable key={index} style={styles.textButton}>
                    <Text style={styles.textButtonText}>{text}</Text>
                  </Pressable>
                )
              )}
            </ScrollView>
          </View>

          {/* Job Listings */}
          <View style={styles.jobList}>
            {jobData.map((job) => (
              <JobCard key={job.id} job={job} />
            ))}
          </View>
        </View>
      </ScrollView>

      {/* Bottom Navigation */}
      <View style={styles.bottomNav}>
        <Pressable>
          <Image source={require('../../assets/PNG/home.png')} style={styles.navIcon} />
        </Pressable>
        <Pressable>
          <Image source={require('../../assets/PNG/connect.png')} style={styles.navIcon} />
        </Pressable>
        <View style={styles.addButtonContainer}>
          <Pressable style={styles.addButton}>
            <Image source={require('../../assets/PNG/plus.png')} style={styles.plusIcon} />
          </Pressable>
        </View>
        <Pressable>
          <Image source={require('../../assets/PNG/chart.png')} style={styles.navIcon} />
        </Pressable>
        <Pressable>
          <Image source={require('../../assets/PNG/save.png')} style={styles.navIcon} />
        </Pressable>
      </View>
    </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F9F9F9',
  },
  contentScrollView: {
    flex: 1,
  },
  header: {
    height: 230,
    marginTop: -23,
  },
  inputsOverlay: {
    padding: 20,
    paddingTop: 40,
  },
  backButton: {
    marginBottom: 10,
  },
  searchContainer: {
    gap: 15,
  },
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderRadius: 10,
    paddingHorizontal: 10,
    height: 44,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  icon: {
    width: 16,
    height: 16,
    marginRight: 10,
  },
  textInput: {
    flex: 1,
    fontSize: 16,
    color: '#333',
  },
  content: {
    flex: 1,
    padding: 16,
    paddingBottom: 70, // Add extra padding at the bottom to account for the fixed bottom nav
  },
  filterContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  iconButton: {
    width: 40,
    height: 40,
    backgroundColor: '#130160',
    borderRadius: 10,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 10,
  },
  iconImage: {
    width: 24,
    height: 24,
    resizeMode: 'contain',
  },
  scrollContainer: {
    paddingRight: 16,
  },
  textButton: {
    backgroundColor: '#F1F1F1',
    borderRadius: 12,
    paddingHorizontal: 12,
    paddingVertical: 8,
    marginRight: 8,
  },
  textButtonText: {
    fontSize: 14,
    color: '#333',
    fontWeight: '600',
  },
  jobList: {
    flex: 1,
  },
  jobCard: {
    flexDirection: 'column',
    alignItems: 'flex-start',
    backgroundColor: '#FFF',
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  jobLogo: {
    width: 40,
    height: 40,
    resizeMode: 'contain',
    marginRight: 16,
  },
  jobInfo: {
    flex: 1,
  },
  jobTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
  },
  companyInfo: {
    fontSize: 14,
    color: '#666',
    marginBottom: 14,
  },
  tagsRow: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  tag: {
    backgroundColor: '#F1F1F1',
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 4,
    marginRight: 8,
    marginBottom: 16,
    fontSize: 12,
    color: '#333',
  },
  salary: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#4A3AFF',
  },
  bottomNav: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
    paddingVertical: 10,
    backgroundColor: '#FFFFFF',
    borderTopWidth: 1,
    borderTopColor: '#EEEEEE',
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    zIndex: 10,
  },
  navIcon: {
    width: 24,
    height: 24,
  },
  addButtonContainer: {
    marginTop: -30,
  },
  addButton: {
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: '#1A1150',
    justifyContent: 'center',
    alignItems: 'center',
  },
  plusIcon: {
    width: 24,
    height: 24,
    tintColor: '#FFFFFF',
  },
});

export default JobSearchScreen;

