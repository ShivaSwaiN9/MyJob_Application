import React, { useState } from 'react';
import {
  SafeAreaView,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
  Image,
  ImageBackground,
  Pressable,
  FlatList,
  Modal,
} from 'react-native';
import { recentJobs } from '../../utils/jobs';

const Organization = ({navigation}:any) => {
   
  const [isModalVisible, setIsModalVisible] = useState(false);
  
  const specializationData = [
    { image: require('../../assets/PNG/Design.png'), title: 'Design', jobs: 120 },
    { image: require('../../assets/PNG/Finance.png'), title: 'Finance', jobs: 250 },
    { image: require('../../assets/PNG/Education.png'), title: 'Education', jobs: 120 },
    { image: require('../../assets/PNG/Restu.png'), title: 'Restaurant', jobs: 85 },
    { image: require('../../assets/PNG/Health.png'), title: 'Health', jobs: 235 },
    { image: require('../../assets/PNG/Programmer.png'), title: 'Programmer', jobs: 412 },
  ];

  const renderJobCard = ({ item }: { item: any }) => (
    <Pressable style={styles.jobCard}>
      <Image source={item.logo} style={styles.companyLogo} />
      <View style={styles.jobInfo}>
        <Text style={styles.jobTitle}>{item.title}</Text>
        <Text style={styles.companyLocation}>{`${item.company} - ${item.location}`}</Text>
        <View style={styles.tags}>
          {item.tags.map((tag: string, index: number) => (
            <View key={index} style={styles.tag}>
              <Text style={styles.tagText}>{tag}</Text>
            </View>
          ))}
        </View>
      </View>
      <Pressable style={styles.bookmarkButton}>
        <Image source={require('../../assets/PNG/save.png')} style={styles.icon} />
      </Pressable>
    </Pressable>
  );

  return (
    <SafeAreaView style={styles.container}>
      <ImageBackground
        source={require('../../assets/PNG/BGG.png')}
        style={styles.headerBackground}
      >
        <View style={styles.header}>
          <View>
            <Text style={styles.greeting}>Hi,</Text>
            <Text style={styles.name}>P Krishnakant</Text>
          </View>
          <View style={styles.rightSection}>
            <Pressable style={styles.notificationButton} onPress={() => navigation.navigate('Notifications')}>
              <Image source={require('../../assets/PNG/Bell.png')} style={styles.icon} />
            </Pressable>
            <Image
              source={require('../../assets/PNG/Profile.png')}
              style={styles.profileImage}
            />
          </View>
        </View>
        <View style={styles.searchBarContainer}>
          <View style={styles.searchContainer}>
            <Image source={require('../../assets/PNG/Search.png')} style={styles.searchIcon} />
            <TextInput
              placeholder="Search"
              style={styles.input}
              placeholderTextColor="#000"
            />
          </View>
          <Pressable style={styles.filterButton}>
            <Image source={require('../../assets/PNG/filter.png')} style={styles.icon} />
          </Pressable>
        </View>
      </ImageBackground>
      <ScrollView showsVerticalScrollIndicator={false} style={styles.scrollContent}>
        <View style={styles.specializationContainer}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>Specialization</Text>
            <Pressable>
              <Text style={styles.viewAll}>View all</Text>
            </Pressable>
          </View>
          <View style={styles.specializationGrid}>
            {specializationData.map((item, index) => (
              <Pressable key={index} style={styles.specializationItem}>
                <View style={styles.iconContainer}>
                  <Image source={item.image} style={styles.specializationIcon} />
                </View>
                <Text style={styles.specializationTitle}>{item.title}</Text>
                <Text style={styles.jobCount}>{item.jobs} Jobs</Text>
              </Pressable>
            ))}
          </View>
        </View>
        <View style={styles.jobRecommendationContainer}>
          <Text style={styles.sectionTitle}>Job Recommendation</Text>
          <FlatList
            data={recentJobs}
            renderItem={renderJobCard}
            keyExtractor={(item) => item.id}
            showsVerticalScrollIndicator={false}
          />
        </View>
      </ScrollView>
      <View style={styles.bottomNav}>
        <Pressable>
        <Image source={require('../../assets/PNG/home.png')} style={styles.navIcon} />
        </Pressable>
        <Pressable>
        <Image source={require('../../assets/PNG/connect.png')} style={styles.navIcon} />
        </Pressable>
        <View style={styles.addButtonContainer}>
          <Pressable style={styles.addButton}  onPress={() => setIsModalVisible(true)}>
            <Image source={require('../../assets/PNG/plus.png')} style={styles.plusIcon} />
          </Pressable>
        </View>
        <Pressable  onPress={() => navigation.navigate('Notifications')}>
        <Image source={require('../../assets/PNG/chart.png')} style={styles.navIcon} />
        </Pressable>
        <Pressable>
        <Image source={require('../../assets/PNG/save.png')} style={styles.navIcon} />
        </Pressable>
      </View>

       <Modal
        animationType="slide"
        transparent={true}
        visible={isModalVisible}
        onRequestClose={() => setIsModalVisible(false)}
      >
        <Pressable 
          style={styles.modalOverlay}
          onPress={() => setIsModalVisible(false)}
        >
          <View style={styles.modalContent}>
            <View style={styles.modalHandle} />
            <Text style={styles.modalTitle}>What would you like to add?</Text>
            <Text style={styles.modalDescription}>
              Would you like to post your tips and experiences or create a job?
            </Text>
            <Pressable 
              style={styles.postButton}
              onPress={() => {
                setIsModalVisible(false);
                // Add your POST action here
              }}
            >
              <Text style={styles.postButtonText}>POST</Text>
            </Pressable>
            <Pressable 
              style={styles.makeJobButton}
              onPress={() => {
                setIsModalVisible(false);
                navigation.navigate('JobPost');
              }}
            >
              <Text style={styles.makeJobButtonText}>MAKE A JOB</Text>
            </Pressable>
          </View>
        </Pressable>
      </Modal>  
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  headerBackground: {
    flex:0.3,
    paddingBottom: 30,
    borderBottomLeftRadius: 24,
    borderBottomRightRadius: 24,
    overflow: 'hidden',
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingTop: 20,
  },
  greeting: {
    color: '#fff',
    fontSize: 16,
  },
  name: {
    color: '#fff',
    fontSize: 20,
    fontWeight: 'bold',
  },
  rightSection: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 15,
  },
  notificationButton: {
    padding: 8,
  },
  profileImage: {
    width: 40,
    height: 40,
    borderRadius: 20,
  },
  searchBarContainer: {
    flexDirection: 'row',
    paddingHorizontal: 20,
    gap: 10,
    marginTop: 20,
  },
  searchContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderRadius: 12,
    paddingHorizontal: 15,
  },
  searchIcon: {
    width: 20,
    height: 20,
    marginRight: 10,
  },
  input: {
    flex: 1,
    height: 45,
    fontSize: 16,
  },
  filterButton: {
    backgroundColor: '#FF6B2C',
    width: 45,
    height: 45,
    borderRadius: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  scrollContent: {
    flex: 1,
  },
  specializationContainer: {
    padding: 20,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 15,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#1A1A1A',
  },
  viewAll: {
    color: '#666',
  },
  specializationGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 15,
  },
  specializationItem: {
    width: '30%',
    backgroundColor: '#fff',
    padding: 15,
    borderRadius: 12,
    alignItems: 'center',
  },
  iconContainer: {
    width: 45,
    height: 45,
    borderRadius: 12,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
    backgroundColor: '#FF6B2C',
  },
  specializationIcon: {
    width: 24,
    height: 24,
  },
  specializationTitle: {
    fontSize: 12,
    fontWeight: '500',
    marginBottom: 4,
  },
  jobCount: {
    fontSize: 12,
    color: '#666',
  },
  jobRecommendationContainer: {
    padding: 20,
  },
  jobCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 15,
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginTop:10,
  },
  companyLogo: {
    width: 40,
    height: 40,
    borderRadius: 8,
    marginRight: 12,
  },
  jobInfo: {
    flex: 1,
  },
  jobTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  companyLocation: {
    fontSize: 14,
    color: '#666',
    marginBottom: 8,
  },
  tags: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  tag: {
    backgroundColor: '#F5F5F5',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 6,
  },
  tagText: {
    fontSize: 12,
    color: '#666',
  },
  bookmarkButton: {
    padding: 8,
  },
  bottomNavigation: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
    backgroundColor: '#fff',
    paddingVertical: 10,
    borderTopWidth: 1,
    borderTopColor: '#F5F5F5',
  },
  navTab: {
    padding: 10,
  },
//   addButton: {
//     backgroundColor: '#FF6B2C',
//     width: 50,
//     height: 50,
//     borderRadius: 25,
//     justifyContent: 'center',
//     alignItems: 'center',
//     marginTop: -25,
//   },
  icon: {
    width: 24,
    height: 24,
  },
  addIcon: {
    width: 24,
    height: 24,
    tintColor: '#fff',
  },
  bottomNav: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
    paddingVertical: 10,
    backgroundColor: '#FFFFFF',
    borderTopWidth: 1,
    borderTopColor: '#EEEEEE',
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
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'flex-end',
  },
  modalContent: {
    backgroundColor: 'white',
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    padding: 20,
    alignItems: 'center',
  },
  modalHandle: {
    width: 40,
    height: 4,
    backgroundColor: '#E5E5E5',
    borderRadius: 2,
    marginBottom: 20,
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#000',
  },
  modalDescription: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    marginBottom: 20,
  },
  postButton: {
    backgroundColor: '#4B0082',
    width: '100%',
    padding: 15,
    borderRadius: 8,
    marginBottom: 10,
  },
  postButtonText: {
    color: 'white',
    textAlign: 'center',
    fontSize: 16,
    fontWeight: 'bold',
  },
  makeJobButton: {
    backgroundColor: '#E6E6FA',
    width: '100%',
    padding: 15,
    borderRadius: 8,
  },
  makeJobButtonText: {
    color: '#4B0082',
    textAlign: 'center',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default Organization;

