import React, { useState } from 'react';
import { View, Text, Pressable, StyleSheet, FlatList } from 'react-native';
import { useNavigation } from '@react-navigation/native';

const LanguageSelection = () => {
  const navigation = useNavigation();
  const [selectedLanguage, setSelectedLanguage] = useState('en'); // Default selected language

  // Example language list
  const languages = [
    { code: 'en', name: 'English' },
    { code: 'es', name: 'Spanish' },
    { code: 'fr', name: 'French' },
    { code: 'de', name: 'German' },
    { code: 'hi', name: 'Hindi' },
    { code: 'zh', name: 'Chinese' },
  ];

  const handleLanguageSelection = (code) => {
    setSelectedLanguage(code);
    // Optionally save the selection in AsyncStorage or backend
    console.log(`Selected language: ${code}`);
    navigation.goBack(); // Navigate back to the Settings page
  };

  const renderLanguageItem = ({ item }) => (
    <Pressable
      style={[
        styles.languageItem,
        selectedLanguage === item.code && styles.selectedLanguageItem,
      ]}
      onPress={() => handleLanguageSelection(item.code)}
    >
      <Text
        style={[
          styles.languageText,
          selectedLanguage === item.code && styles.selectedLanguageText,
        ]}
      >
        {item.name}
      </Text>
    </Pressable>
  );

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Select Your Language</Text>
      <FlatList
        data={languages}
        keyExtractor={(item) => item.code}
        renderItem={renderLanguageItem}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    textAlign: 'center',
  },
  languageItem: {
    padding: 15,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    marginBottom: 10,
    backgroundColor: '#fff',
  },
  selectedLanguageItem: {
    borderColor: '#4caf50',
    backgroundColor: '#e8f5e9',
  },
  languageText: {
    fontSize: 18,
    color: '#333',
  },
  selectedLanguageText: {
    color: '#4caf50',
    fontWeight: 'bold',
  },
});

export default LanguageSelection;
