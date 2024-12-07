import React, { useState } from 'react';
import {
  SafeAreaView,
  View,
  Text,
  StyleSheet,
  Image,
  Pressable,
  ScrollView,
  Linking,
} from 'react-native';

const ApplyScreen = ({ route, navigation }:any) => {
  const { job } = route.params;
  const [isDescriptionView, setIsDescriptionView] = useState(true);

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView>
        {/* Header */}
        <View style={styles.header}>
          <Image source={job.logo} style={styles.logo} accessibilityLabel={`${job.company} logo`} />
          <Text style={styles.title}>{job.title}</Text>
          <Text style={styles.companyInfo}>
            {job.company} • {job.location} • {job.postedTime}
          </Text>
        </View>

        {/* Toggle Buttons */}
        <View style={styles.row}>
          <Pressable
            style={[
              styles.button,
              isDescriptionView ? styles.descriptionButton : styles.inactiveButton,
            ]}
            onPress={() => setIsDescriptionView(true)}
            accessibilityRole="button"
            accessibilityState={{ selected: isDescriptionView }}
          >
            <Text style={styles.buttonText}>Description</Text>
          </Pressable>

          <Pressable
            style={[
              styles.button,
              !isDescriptionView ? styles.companyButton : styles.inactiveButton,
            ]}
            onPress={() => setIsDescriptionView(false)}
            accessibilityRole="button"
            accessibilityState={{ selected: !isDescriptionView }}
          >
            <Text style={styles.buttonText}>Company</Text>
          </Pressable>
        </View>

        {isDescriptionView ? (
          <>
            {/* Job Description */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Job Description</Text>
              <Text style={styles.text} numberOfLines={3}>
                {job.description}
              </Text>
              <Pressable accessibilityRole="button">
                <Text style={styles.readMore}>Read more</Text>
              </Pressable>
            </View>

            {/* Requirements */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Requirements</Text>
              {job.requirements.map((requirement:string, index:number) => (
                <Text key={index} style={styles.listItem}>
                  • {requirement}
                </Text>
              ))}
            </View>

            {/* Location */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Location</Text>
              <Text style={styles.text}>{job.locationDetails}</Text>
              <Image
                source={job.mapImage}
                style={styles.mapImage}
                accessibilityLabel="Job location map"
              />
            </View>

            {/* Additional Information */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Information</Text>
              {Object.entries(job.informations).map(([key, value], index) => (
                <View key={index} style={styles.infoRow}>
                  <Text style={styles.infoLabel}>{key}:</Text>
                  <Text style={styles.infoValue}>{value}</Text>
                </View>
              ))}
            </View>

            {/* Facilities and Others */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Facilities and Others</Text>
              {job.facilities.map((facility:string, index:number) => (
                <Text key={index} style={styles.listItem}>
                  • {facility}
                </Text>
              ))}
            </View>
          </>
        ) : (
          <>
            {/* About Company */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>About Company</Text>
              {job.about.map((paragraph: string, index: number) => (
                <Text key={index} style={styles.text}>
                  {paragraph}
                </Text>
              ))}
            </View>
            
            {/* Website */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Website</Text>
              <Text style={styles.link} onPress={() => Linking.openURL(job.website)}>
                {job.website}
              </Text>
            </View>
        
            {/* Other Details */}
            {[
              { label: "Industry", value: job.industry },
              { label: "Employee size", value: job.employeeSize },
              { label: "Head office", value: job.headOffice },
              { label: "Type", value: job.type },
              { label: "Since", value: job.since },
              { label: "Specialization", value: job.specialization },
            ].map((item, index) => (
              <View style={styles.section} key={index}>
                <Text style={styles.sectionTitle}>{item.label}</Text>
                <Text style={styles.text}>{item.value}</Text>
              </View>
            ))}
        
            {/* Company Gallery */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Company Gallery</Text>
              <View style={styles.gallery}>
                {job.gallery.map((image: any, index: number) => (
                  <Image key={index} style={styles.image} source={image} accessibilityLabel={`Company image ${index + 1}`} />
                ))}
              </View>
            </View>
          </>
        )}
      </ScrollView>

      {/* Apply Button */}
      <View style={styles.footerContainer}>
      {/* Replace Icon with Image */}
      <Pressable>
      <View style={styles.imageContainer}>
        <Image
          source={require("../../assets/PNG/save.png")}
          style={styles.imageF}
        />
      </View>
      </Pressable>
      <Pressable style={styles.buttonF}  onPress={() => navigation.navigate('UploadCV', { job })} >
        <Text style={styles.buttonTextF}>APPLY NOW</Text>
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
  header: {
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#F9FAFB',
    borderBottomWidth: 1,
    borderBottomColor: '#E5E7EB',
  },
  logo: {
    width: 60,
    height: 60,
    marginBottom: 15,
    borderRadius: 30,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#111827',
    marginBottom: 5,
  },
  companyInfo: {
    fontSize: 16,
    color: '#6B7280',
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  button: {
    width: 150,
    paddingVertical: 15,
    borderRadius: 10,
    marginVertical: 10,
    alignItems: 'center',
  },
  descriptionButton: {
    backgroundColor: '#e0e0ff',
    shadowColor: '#000', 
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.8,
    shadowRadius: 2,
    elevation: 3,
  },
  companyButton: {
    backgroundColor: '#e0e0ff',
    shadowColor: '#000', 
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.8,
    shadowRadius: 2,
    elevation: 3,
  },
  inactiveButton: {
    backgroundColor: '#F3F4F6',
  },
  buttonText: {
    color: '#000000',
    fontWeight: 'bold',
  },
  section: {
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#E5E7EB',
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#111827',
    marginBottom: 10,
  },
  text: {
    fontSize: 14,
    color: '#374151',
    lineHeight: 20,
  },
  readMore: {
    fontSize: 14,
    color: '#3B82F6',
    marginTop: 10,
  },
  listItem: {
    fontSize: 14,
    color: '#374151',
    marginBottom: 5,
    lineHeight: 20,
  },
  mapImage: {
    width: '100%',
    height: 150,
    borderRadius: 10,
    marginTop: 10,
  },
  infoRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    marginVertical: 10,
  },
  infoLabel: {
    fontSize: 14,
    color: '#6B7280',
    fontWeight: 'bold',
  },
  infoValue: {
    fontSize: 14,
    color: '#374151',
    marginLeft: 10,
  },
  link: {
    fontSize: 14,
    color: "#3B82F6",
    textDecorationLine: "underline",
  },
  gallery: {
    flexDirection: "row",
    flexWrap: "wrap",
    marginTop: 10,
  },
  image: {
    width: 100,
    height: 100,
    borderRadius: 10,
    marginRight: 10,
    marginBottom: 10,
  },
  footerContainer: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    padding: 16,
    backgroundColor: "#FFFFFF",
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: -2 },
    shadowOpacity: 0.1,
    shadowRadius: 6,
    elevation: 4,
  },
  imageContainer: {
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: "#F5F5F5",
    alignItems: "center",
    justifyContent: "center",
  },
  imageF: {
    width: 24, // Adjust size as needed
    height: 24, // Adjust size as needed
    resizeMode: "contain",
  },
  buttonF: {
    flex: 1,
    backgroundColor: "#0B053D",
    marginLeft: 16,
    paddingVertical: 14,
    borderRadius: 10,
    alignItems: "center",
  },
  buttonTextF: {
    color: "#FFFFFF",
    fontSize: 16,
    fontWeight: "600",
  },
});

export default ApplyScreen;

