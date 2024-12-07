import React, { useState, useRef, useEffect } from 'react';
import {
  SafeAreaView,
  ScrollView,
  View,
  Text,
  Image,
  StyleSheet,
  ImageBackground,
  Pressable,
  FlatList,
  Dimensions,
} from 'react-native';
import { recentJobs } from '../../utils/jobs';

const { width } = Dimensions.get('window');

const HomeScreen = ({ navigation }: any) => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const sliderRef = useRef<FlatList<any>>(null);

  useEffect(() => {
    const interval = setInterval(() => {
      const nextIndex = (currentIndex + 1) % images.length;
      setCurrentIndex(nextIndex);
      sliderRef.current?.scrollToIndex({ index: nextIndex, animated: true });
    }, 5000);
    return () => clearInterval(interval);
  }, [currentIndex]);

  const renderBannerItem = ({ item }: { item: any }) => (
    <View style={styles.bannerItemContainer}>
      <ImageBackground
        source={item}
        style={styles.promoBanner}
        imageStyle={styles.promoBannerImage}
      />
    </View>
  );

  const [savedJobs, setSavedJobs] = useState<any[]>([]);
  const handleSaveJob = (job: any) => {
    setSavedJobs(prevJobs => [...prevJobs, job]);
    navigation.navigate('SavedJobsScreen');
  };

  const JobCard = ({ item }: { item: any }) => (
    <View style={styles.card}>
      {/* Header Section */}
      <View style={styles.CardHeader}>
        <Image source={item.logo} style={styles.logo} />
        <View style={styles.titleContainer}>
          <Text style={styles.title}>{item.title}</Text>
          <Text style={styles.subtitle}>
            {item.company} • {item.location}
          </Text>
        </View>
        <Pressable onPress={() => handleSaveJob(item)}>
          <Image
            source={require('../../assets/PNG/save.png')}
            style={{ height: 24, width: 24 }}
          />
        </Pressable>
      </View>

      {/* Salary Section */}
      <Text style={styles.salary}>{item.salary}/mo</Text>

      {/* Tags Section */}
      <View style={styles.tagsContainer}>
        {item.tags.map((tag: string, index: number) => (
          <View style={styles.tag} key={index}>
            <Text style={styles.tagText}>{tag}</Text>
          </View>
        ))}

        {/* Apply Button */}
        <Pressable
          style={styles.applyButton}
          onPress={() => navigation.navigate('ApplyScreen', { job: item })}>
          <Text style={styles.applyText}>Apply</Text>
        </Pressable>
      </View>
    </View>
  );

  const images = [
    require('../../assets/Banner/1.jpg'),
    require('../../assets/Banner/2.png'),
    require('../../assets/Banner/3.png'),
    require('../../assets/Banner/4.png'),
    require('../../assets/Banner/5.png'),
    require('../../assets/PNG/Banner.png'),
  ];

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView>
        {/* Header Section */}
        <View style={styles.header}>
          <View>
            <Text style={styles.hello}>Hello</Text>
            <Text style={styles.name}>P Krishnakant</Text>
          </View>
          <Pressable onPress={() => navigation.navigate('MyProfile')}>
            <Image
              source={require('../../assets/PNG/Profile.png')}
              style={styles.profileImage}
            />
          </Pressable>
        </View>

        <FlatList
          ref={sliderRef}
          data={images}
          renderItem={renderBannerItem}
          keyExtractor={(_, index) => index.toString()}
          horizontal
          pagingEnabled
          showsHorizontalScrollIndicator={false}
          onMomentumScrollEnd={event => {
            const newIndex = Math.round(
              event.nativeEvent.contentOffset.x / width,
            );
            setCurrentIndex(newIndex);
          }}
        />

        {/* Find Your Job Section */}
        <View style={{ flex: 0.3 }}>
          <Text style={styles.sectionTitle}>Find Your Job</Text>
          <View style={styles.statsContainer}>
            <Pressable style={[styles.statsCard, { backgroundColor: '#E5F5FF' }]} onPress={() => navigation.navigate('JobSearchScreen')}>
              <Image
                source={require('../../assets/PNG/RemoteJob.png')}
                style={styles.statsIcon}
              />
              <Text style={styles.statsNumber}>44.5k</Text>
              <Text style={styles.statsLabel}>Remote Job</Text>
            </Pressable>
            <Pressable
              style={[styles.statsCard, { backgroundColor: '#F0E8FF' }]}
              onPress={() => navigation.navigate('JobSearchScreen')}>
              <Text style={styles.statsNumber}>66.8k</Text>
              <Text style={styles.statsLabel}>Full Time</Text>
            </Pressable>
            <Pressable style={[styles.statsCard, { backgroundColor: '#FFE8D9' }]} onPress={() => navigation.navigate('JobSearchScreen')}>
              <Text style={styles.statsNumber}>38.9k</Text>
              <Text style={styles.statsLabel}>Part Time</Text>
            </Pressable>
          </View>
        </View>

        {/* Recent Job List */}
        <View style={{ flex: 0.3 }}>
          <Text style={styles.sectionTitle}>Recent Job List</Text>
          <FlatList
            data={recentJobs}
            keyExtractor={item => item.id}
            renderItem={JobCard}
            contentContainerStyle={styles.jobListContainer}
            showsVerticalScrollIndicator={false}
          />
        </View>
      </ScrollView>

      {/* Bottom Navigation */}
      <View style={styles.bottomNav}>
        <Pressable>
          <Image
            source={require('../../assets/PNG/home.png')}
            style={styles.navIcon}
          />
        </Pressable>
        <Pressable onPress={() => navigation.navigate('JobSearchScreen')}>
          <Image
            source={require('../../assets/PNG/loupe.png')}
            style={styles.navIcon}
          />
        </Pressable>
        <View style={styles.addButtonContainer}>
          <Pressable style={styles.addButton}>
            <Image
              source={require('../../assets/PNG/plus.png')}
              style={styles.plusIcon}
            />
          </Pressable>
        </View>
        <Pressable onPress={() => navigation.navigate('Notifications')}>
          <Image
            source={require('../../assets/PNG/chart.png')}
            style={styles.navIcon}
          />
        </Pressable>
        <Pressable onPress={() => navigation.navigate('SavedJobsScreen')}>
          <Image
            source={require('../../assets/PNG/save.png')}
            style={styles.navIcon}
          />
        </Pressable>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  bannerItemContainer: {
    width: width,
    paddingHorizontal: 10,
  },
  promoBanner: {
    width: '100%',
    height: 200,
    justifyContent: 'center',
    alignItems: 'center',
  },
  promoBannerImage: {
    borderRadius: 12,
    resizeMode: 'cover',
  },
  joinButtonText: {
    color: '#FFFFFF',
    fontWeight: 'bold',
  },
  header: {
    flex: 0.2,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 20,
  },
  hello: {
    fontSize: 16,
    color: '#000000',
  },
  name: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#000000',
  },
  profileImage: {
    width: 40,
    height: 40,
    borderRadius: 20,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginLeft: 20,
    marginTop: 20,
    marginBottom: 10,
  },
  jobListContainer: { paddingHorizontal: 20, paddingBottom: 20 },
  statsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    margin: 8,
    justifyContent: 'space-between',
  },
  statsCard: {
    width: '48%',
    aspectRatio: 2,
    borderRadius: 10,
    padding: 15,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 15,
  },
  statsIcon: {
    width: 24,
    height: 24,
    marginBottom: 5,
  },
  statsNumber: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#000000',
  },
  statsLabel: {
    fontSize: 12,
    color: '#666666',
  },
  card: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 6,
    elevation: 5,
    marginBottom: 16,
  },
  CardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  logo: {
    width: 40,
    height: 40,
    borderRadius: 20,
    marginRight: 12,
  },
  titleContainer: {
    flex: 1,
  },
  title: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#222',
  },
  subtitle: {
    fontSize: 14,
    color: '#555',
    marginTop: 4,
  },
  salary: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#222',
    marginBottom: 16,
  },
  tagsContainer: {
    flexDirection: 'row',
    marginBottom: 10,
    justifyContent: 'space-around',
  },
  tag: {
    backgroundColor: '#f0f0f0',
    paddingVertical: 6,
    paddingHorizontal: 12,
    borderRadius: 20,
    marginRight: 8,
  },
  tagText: {
    fontSize: 14,
    color: '#555',
  },
  applyButton: {
    backgroundColor: '#FFE4E1',
    padding: 10,
    paddingHorizontal: 20,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 8,
  },
  applyText: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#FF5C5C',
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
});

export default HomeScreen;