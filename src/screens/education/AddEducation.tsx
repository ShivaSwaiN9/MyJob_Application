import CheckBox from '@react-native-community/checkbox';
import { useNavigation } from '@react-navigation/native';
import React, { useState } from 'react';
import { View, Text, TextInput, StyleSheet, Pressable, Image, Modal, FlatList, Dimensions } from 'react-native';

const months = [
  'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December',
];

const years = [];
for (let i = 2000; i <= 2030; i++) {
  years.push(i.toString());
}

const AddEducation = ({ visible, onClose, onSelect }:any) => {
  const navigation = useNavigation();

  const [levelOfEducation, setLevelOfEducation] = useState('');
  const [institutionName, setInstitutionName] = useState('');
  const [fieldOfStudy, setFieldOfStudy] = useState('');
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [isChecked, setIsChecked] = useState(false); // State to handle checkbox
  const [isCurrentPosition, setIsCurrentPosition] = useState(false);
  const [description, setDescription] = useState('');
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [selectedMonth, setSelectedMonth] = useState('');
  const [selectedYear, setSelectedYear] = useState('');
  const [isEducationModalVisible, setIsEducationModalVisible] = useState(false);
  const [isInstitutionModalVisible, setIsInstitutionModalVisible] = useState(false);
  const [isStudyModalVisible, setIsStudyModalVisible] = useState(false);

  const handleDateSelect = (type, value) => {
    if (type === 'month') {
      setSelectedMonth(value);
    } else if (type === 'year') {
      setSelectedYear(value);
    }
  };
  const handleSave = () => {
    // Set the selected month and year as the start date
    setStartDate(`${selectedMonth} ${selectedYear}`);
    // setEndDate(`${selectedMonth} ${selectedYear}`);
    setIsModalVisible(false);
  };
  

  const handleSaveEnd = () => {
    // Set the selected month and year as the start date
    // setStartDate(${selectedMonth} ${selectedYear});
    setEndDate(`${selectedMonth} ${selectedYear}`);
    setIsModalVisible(false);
  };

  const handleSubmit = () => {
    // Handle form submission logic here
    console.log({
      levelOfEducation,
      institutionName,
      fieldOfStudy,
      startDate,
      endDate: isCurrentPosition ? 'Present' : endDate,
      description,
    });
  };


  const [searchTerm, setSearchTerm] = useState('');

  const educationLevels = [
    'Bachelor of Electronic Engineering (Industrial Electronics)',
    'Bachelor of Information Technology',
    'Economics (Bachelor of Science), Psychology',
    'Bachelor of Arts (Hons) Mass Communication With Public Relations',
    'Bachelor of Science in Computer Science',
    'Bachelors of Science in Marketing',
    'Bachelor of Engineering With A Major in Engineering Product Development (Robotic Track)',
    'Bachelor of Business (Economics/Finance)',
    'Bachelors of Business Administration',
  ];

  // Filter data based on the search term
  const filteredData = educationLevels.filter((item) => {
    if (!searchTerm) return true; // Show all items if searchTerm is empty
    return item.toLowerCase().includes(searchTerm.toLowerCase()); // Match input text
  });

  const handleClearSearch = () => {
    setSearchTerm('');
  };


  const [searchTermInstitute, setSearchTermInstitute] = useState('');

  const institutions = [
    "University of Oxford",
    "National University of Lesotho International School",
    "University of Chester CE Academy",
    "University of Chester Academy Northwich",
    "University of Birmingham School",
    "Bloomsburg University of Pennsylvania",
    "California University of Pennsylvania",
    "Clarion University of Pennsylvania",
    "East Stroudsburg State University of Pennsylvania",
  ];

  // Filter data based on the first letter
  const filteredDataInstitution = institutions.filter((item) => {
    if (!searchTermInstitute) return true; // Show all items if searchTerm is empty
    return item[0].toLowerCase() === searchTermInstitute[0]?.toLowerCase(); // Match first letter
  });

  const handleClearSearchInstitution = () => {
    setSearchTermInstitute('');
  };


  const [searchTermStudy, setSearchTermStudy] = useState('');

  const study = [
    "Information Technology",
    "Business Information Systems",
    "Computer Information Science",
    "Computer Information Systems",
    "Healt Information Management",
    "History and Information",
    "Information Assurance",
    "Information Security",
    "Information Systems",
  ];

  const filteredDataStudy = study.filter((item) => {
    if (!searchTermStudy) return true; // Show all items if searchTerm is empty
    return item[0].toLowerCase() === searchTermStudy[0]?.toLowerCase(); // Match first letter
  });

  const handleClearSearchStudy = () => {
    setSearchTermStudy('');
  };

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Pressable onPress={() => navigation.goBack()}>
          <Image
            source={require("../../assets/PNG/blackBack.png")}
            style={styles.backImage}
          />
        </Pressable>
      </View>
      <Text style={styles.title}>Add Education</Text>

      {/* Level of Education */}
      <Text style={styles.label}>Level of education</Text>
      <Pressable
  style={styles.input}
  onPress={() => setIsEducationModalVisible(true)} // Open modal
>
  <Text style={styles.inputText}>{levelOfEducation || 'Select level of education'}</Text>
</Pressable>

<Modal
  visible={isEducationModalVisible} // Use the correct state
  animationType="slide"
  transparent={true}
  onRequestClose={() => setIsEducationModalVisible(false)} // Handle modal close
>
  <View style={styles.modalContainer}>
    <View style={styles.modalContent}>
      {/* Header */}
      {/* <View style={styles.header}>
        <Pressable onPress={() => setIsEducationModalVisible(false)}>
          <Image
            source={require('../../assets/PNG/blackBack.png')}
            style={styles.backImage}
          />
        </Pressable>
        <Text style={styles.title}>Level of Education</Text>
      </View> */}

      {/* Search Bar */}
      <View style={styles.searchContainer}>
        <Image
          source={require('../../assets/PNG/Iconsearch.png')}
          style={styles.icon}
        />
        <TextInput
          style={styles.searchInput}
          placeholder="Search..."
          value={searchTerm}
          onChangeText={setSearchTerm}
        />
        {searchTerm.length > 0 && (
          <Pressable onPress={handleClearSearch}>
            <Image
              source={require('../../assets/PNG/Remove.png')}
              style={styles.clearButton}
            />
          </Pressable>
        )}
      </View>

      {/* Education List */}
      <FlatList
        data={filteredData}
        keyExtractor={(item, index) => index.toString()}
        renderItem={({ item }) => (
          <Pressable
            style={styles.itemContainer}
            onPress={() => {
              setLevelOfEducation(item); // Update selected value
              setIsEducationModalVisible(false); // Close modal
            }}
          >
            <Text style={styles.itemText}>{item}</Text>
          </Pressable>
        )}
      />
    </View>
  </View>
</Modal>

      {/* Institution Name */}
      <Text style={styles.label}>Institution name</Text>
      <Pressable
  style={styles.input}
  onPress={() => setIsInstitutionModalVisible(true)} // Open modal
>
  <Text style={styles.inputText}>{institutionName || 'Select level of Institution'}</Text>
</Pressable>

<Modal
      visible={isInstitutionModalVisible}
      animationType="slide"
      transparent={true}
      onRequestClose={() => setIsInstitutionModalVisible(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalContent}>
         
          <View style={styles.searchContainer}>
            <Image
              source={require('../../assets/PNG/Iconsearch.png')}
              style={styles.icon}
            />
            <TextInput
              style={styles.searchInput}
              placeholder="Search..."
              value={searchTerm}
              onChangeText={setSearchTermInstitute}
            />
            {searchTerm.length > 0 && (
              <Pressable onPress={handleClearSearchInstitution}>
                <Image
                  source={require('../../assets/PNG/Remove.png')}
                  style={styles.clearButton}
                />
              </Pressable>
            )}
          </View>

          {/* Institution List */}
          <FlatList
            data={filteredDataInstitution}
            keyExtractor={(item, index) => index.toString()}
            renderItem={({ item }) => (
              <Pressable
                style={styles.itemContainer}
                onPress={() => {
                  setInstitutionName(item); // Update selected value
                  setIsInstitutionModalVisible(false); // Close modal
                }}
              >
                <Text style={styles.itemText}>{item}</Text>
              </Pressable>
            )}
          />
        </View>
      </View>
    </Modal>

      {/* Field of Study */}
      <Text style={styles.label}>Field of study</Text>
      <Pressable
  style={styles.input}
  onPress={() => setIsStudyModalVisible(true)} // Open modal
>
  <Text style={styles.inputText}>{fieldOfStudy || 'Select Field of study'}</Text>
</Pressable>

<Modal
      visible={isStudyModalVisible}
      animationType="slide"
      transparent={true}
      onRequestClose={() => setIsStudyModalVisible(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalContent}>
          
          <View style={styles.searchContainer}>
            <Image
              source={require('../../assets/PNG/Iconsearch.png')}
              style={styles.icon}
            />
            <TextInput
              style={styles.searchInput}
              placeholder="Search..."
              value={searchTerm}
              onChangeText={setSearchTermStudy}
            />
            {searchTerm.length > 0 && (
              <Pressable onPress={handleClearSearchStudy}>
                <Image
                  source={require('../../assets/PNG/Remove.png')}
                  style={styles.clearButton}
                />
              </Pressable>
            )}
          </View>

          {/* Institution List */}
          <FlatList
            data={filteredDataStudy}
            keyExtractor={(item, index) => index.toString()}
            renderItem={({ item }) => (
              <Pressable
                style={styles.itemContainer}
                onPress={() => {
                  setFieldOfStudy(item); // Update selected value
                  setIsStudyModalVisible(false); // Close modal
                }}
              >
                <Text style={styles.itemText}>{item}</Text>
              </Pressable>
            )}
          />
        </View>
      </View>
    </Modal>

      {/* Start and End Date */}
      <View style={styles.dateContainer}>
        <View style={styles.inputContainer}>
          <Text style={styles.label}>Start date</Text>
          <Pressable
            style={styles.input}
            onPress={() => setIsModalVisible(true)}
          >
            <Text style={styles.inputText}>{startDate || 'MM/YYYY'}</Text>
          </Pressable>
        </View>
        <View style={styles.dateField}>
          <View style={styles.inputContainer}>
            <Text style={styles.label}>End date</Text>
            <Pressable
            style={styles.input}
            onPress={() => setIsModalVisible(true)}
          >
            <Text style={styles.inputText}>{endDate || 'MM/YYYY'}</Text>
          </Pressable>
          </View>
        </View>
      </View>

      {/* Current Position Checkbox */}
      <View style={styles.checkboxContainer}>
        <CheckBox
          value={isChecked}
          onValueChange={(newValue) => setIsChecked(newValue)}
          tintColors={{ true: 'green', false: 'gray' }}
        />
        <Text style={styles.checkboxLabel}>This is a current position</Text>
      </View>

      {/* Description */}
      <Text style={styles.label}>Description</Text>
      <TextInput
        style={[styles.inputContainer, styles.textArea]}
        value={description}
        onChangeText={setDescription}
        placeholder="Write additional information here"
        multiline
      />

      {/* Submit Button */}
      <Pressable
        style={[styles.button, styles.applyButton]}
        // onPress={handleSubmit}
        onPress={() => navigation.navigate('AddResume')}
      >
        <Text style={styles.buttonText}>Apply</Text>
      </Pressable>

      {/* Modal for Date Selection */}
      <Modal
        visible={isModalVisible}
        animationType="slide"
        transparent={true}
        onRequestClose={() => setIsModalVisible(false)}
      >
        <View style={styles.modalContainer}>
          <View style={styles.modalContent}>
            <Text style={styles.modalTitle}>Select  Date</Text>
            <View style={styles.row}>
              {/* Month Picker */}
              <FlatList
                data={months}
                keyExtractor={(item) => item}
                renderItem={({ item }) => (
                  <Pressable
                    style={[
                      styles.listItem,
                      item === selectedMonth && styles.selectedItem,
                    ]}
                    onPress={() => handleDateSelect('month', item)}
                  >
                    <Text style={styles.listItemText}>{item}</Text>
                  </Pressable>
                )}
                style={styles.scrollContainer}
              />

              {/* Year Picker */}
              <FlatList
                data={years}
                keyExtractor={(item) => item}
                renderItem={({ item }) => (
                  <Pressable
                    style={[
                      styles.listItem,
                      item === selectedYear && styles.selectedItem,
                    ]}
                    onPress={() => handleDateSelect('year', item)}
                  >
                    <Text style={styles.listItemText}>{item}</Text>
                  </Pressable>
                )}
                style={styles.scrollContainer}
              />
            </View>

            <Pressable onPress={handleSave} style={styles.modalButton}>
              <Text style={styles.modalButtonText}>Save</Text>
            </Pressable>

            <Pressable
              style={styles.modalButton}
              onPress={() => setIsModalVisible(false)}
            >
              <Text style={styles.modalButtonText}>Close</Text>
            </Pressable>
          </View>
        </View>
      </Modal>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    paddingVertical: 10,
    paddingHorizontal: 20,
    backgroundColor: '#fff',
    flex: 1,
  },
  header: {
    height: 30,
    justifyContent: 'flex-start',
  },
  backImage: {
    height: 10,
    width: 20,
    position: 'absolute',
    top: 20,
  },
  icon: {
    width: 20,
    height: 20,
    marginRight: 10,
    tintColor: '#666',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 10,
    marginTop: 10,
  },
  label: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#333',
  },
  input: {
    height: 50,
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 8,
    paddingHorizontal: 16,
    backgroundColor: '#fff',
    fontSize: 16,
    // top:10
  },
  inputText:{
    // padding:10,
    top:10,
    fontSize: 16,
    marginLeft: 4
  },
  inputContainer: {
    marginBottom: 12,
  },
  dateContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  dateField: {
    flex: 1,
    marginLeft: 80,
  },
  checkboxContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 15,
  },
  checkboxLabel: {
    fontSize: 16,
    marginLeft: 8,
  },
  textArea: {
    height: 120,
    textAlignVertical: 'top',
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 8,
    paddingHorizontal: 16,
    fontSize: 16,
  },
  button: {
    backgroundColor: '#C0C0C0', // Orange button
    padding: 10,
    marginVertical: 3,
    borderRadius: 5,
    alignItems: 'center',
  },
  buttonText: {
    color: '#FFFFFF',
    fontSize: 20,
    fontWeight: '500',
  },
  applyButton: {
    backgroundColor: "#130160",
    justifyContent: "center",
    left: 50,
    top: 20,
    width: '60%',
  },
  modalContainer: {
    flex: 1,
    
    justifyContent: 'center',
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
  },
  modalContent: {
    backgroundColor: '#fff',
    margin: 20,
    borderRadius: 8,
    padding: 20,
    alignItems: 'center',
  },
  modalTitle: {
    fontSize: 18,
    marginBottom: 20,
  },
  modalButton: {
    backgroundColor: '#130160',
    padding: 10,
    borderRadius: 8,
    marginTop: 20,
    paddingHorizontal:30
  },
  modalButtonText: {
    color: '#fff',
    fontSize: 16,
  },
  picker: {
    width: 200,
    height: 150,
  },
  scrollContainer: {
    maxHeight: Dimensions.get('window').height * 0.3, // Adjust based on your layout
    marginVertical: 10,
  },
  listItem: {
    padding: 10,
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
  },
  listItemText: {
    fontSize: 16,
  },
  selectedItem: {
    backgroundColor: '#e0e0e0', // Highlight the selected item
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    width: '100%', // Make the row take full width
    marginVertical: 10,
  },
  searchContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 10,
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 8,
    paddingHorizontal: 8,
    backgroundColor: '#fff',
  },
  searchInput: {
    flex: 1,
    height: 40,
    fontSize: 16,
  },
  clearButton: {
    width: 20,
    height: 20,
  },
  itemContainer: {
    paddingVertical: 15,
  },
  itemText: {
    fontSize: 16,
    color: '#333',
  },
});

export default AddEducation;