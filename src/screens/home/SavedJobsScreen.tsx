import React from 'react';
import { View, Text, FlatList, StyleSheet, Image, Pressable } from 'react-native';
import { recentJobs } from '../../utils/jobs';

const SavedJobsScreen = ({ route, navigation }: any) => {

  const renderJobCard = ({ item }: any) => ( 
    <View style={styles.card}>
      <View style={styles.cardHeader}>
        <Image source={item.logo} style={styles.logo} />
        <View style={styles.titleContainer}>
          <Text style={styles.title}>{item.title}</Text>
          <Text style={styles.subtitle}>
            {item.company} • {item.location}
          </Text>
        </View>
        <Pressable>
          <Image
            source={require('../../assets/PNG/more.png')}
            style={styles.moreIcon}
          />
        </Pressable>
      </View>
      <View style={styles.tagsContainer}>
        {item.tags.map((tag: any, index: any) => (
          <View style={styles.tag} key={index}>
            <Text style={styles.tagText}>{tag}</Text>
          </View>
        ))}
      </View>
      <View style={styles.footer}>
        <Text style={styles.postedTime}>{item.postedTime}</Text>
        <Text style={styles.salary}>{item.salary}/Mo</Text>
      </View>
    </View>
  );

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Saved Jobs</Text>
        <Pressable>
          <Text style={styles.deleteAll}>Delete all</Text>
        </Pressable>
      </View>
      <FlatList
        data={recentJobs} // Pass jobs as an array
        renderItem={renderJobCard}
        keyExtractor={(item) => item.id.toString()} // Ensure 'id' is a string
      />
    </View>
  );
};



const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F7FA',
    padding: 16,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: '700',
  },
  deleteAll: {
    fontSize: 14,
    color: '#FF5C5C',
  },
  card: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  cardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  logo: {
    width: 40,
    height: 40,
    marginRight: 12,
  },
  titleContainer: {
    flex: 1,
  },
  title: {
    fontSize: 16,
    fontWeight: '600',
  },
  subtitle: {
    fontSize: 14,
    color: '#757575',
  },
  moreIcon: {
    width: 24,
    height: 24,
  },
  tagsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginVertical: 12,
  },
  tag: {
    backgroundColor: '#F0F0F0',
    borderRadius: 16,
    paddingHorizontal: 8,
    paddingVertical: 4,
    marginRight: 8,
    marginBottom: 8,
  },
  tagText: {
    fontSize: 12,
    color: '#757575',
  },
  footer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  postedTime: {
    fontSize: 12,
    color: '#9E9E9E',
  },
  salary: {
    fontSize: 16,
    fontWeight: '700',
  },
});

export default SavedJobsScreen;