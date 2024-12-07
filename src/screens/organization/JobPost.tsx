import React, {useState} from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  ScrollView,
  Image,
  Modal,
  TextInput,
  FlatList,
} from 'react-native';
import JobShare from './JobShare';

const plusIcon = require('../../assets/PNG/Add.png');
const editIcon = require('../../assets/PNG/Edit.png');
const SearchIcon = require('../../assets/PNG/Search.png');

const jobPositions = [
  'Assistant',
  'Associate',
  'Administrative Assistant',
  'Account Manager',
  'Assistant Manager',
  'Commission Sales Associate',
  'Sales Attendant',
  'Accountant',
  'Sales Advocate',
  'Analyst',
];

const workplaceTypes = [
  {
    id: 'onsite',
    title: 'On-site',
    description: 'Employees come to work',
  },
  {
    id: 'hybrid',
    title: 'Hybrid',
    description: 'Employees work directly on site or off-site',
  },
  {
    id: 'remote',
    title: 'Remote',
    description: 'Employees working off site',
  },
];

const locations = [
  'Califon, United States',
  'California, United States',
  'California City, United States',
  'Dallas, United States',
  'Denver, United States',
  'Detroit, United States',
  'Houston, United States',
];

const companies = [
  {
    id: '1',
    name: 'Google',
    industry: 'Internet',
    logo: require('../../assets/PNG/google.png'),
  },
  {
    id: '2',
    name: 'Apple',
    industry: 'Electronic goods',
    logo: require('../../assets/PNG/google.png'),
  },
  {
    id: '3',
    name: 'Amazon',
    industry: 'Internet',
    logo: require('../../assets/PNG/google.png'),
  },
  {
    id: '4',
    name: 'Dribbble',
    industry: 'Design',
    logo: require('../../assets/PNG/google.png'),
  },
  {
    id: '5',
    name: 'Twitter',
    industry: 'Internet',
    logo: require('../../assets/PNG/google.png'),
  },
  {
    id: '6',
    name: 'Facebook',
    industry: 'Internet',
    logo: require('../../assets/PNG/google.png'),
  },
  {
    id: '7',
    name: 'Microsoft',
    industry: 'Computer software',
    logo: require('../../assets/PNG/google.png'),
  },  
  {
    id: '8',
    name: 'Allianz',
    industry: 'Financial services',
    logo: require('../../assets/PNG/google.png'),
  },
  {
    id: '9',
    name: 'Adobe',
    industry: 'Computer software',
    logo: require('../../assets/PNG/google.png'),
  },
  {
    id: '10',
    name: 'AXA',
    industry: 'Insurance',
    logo: require('../../assets/PNG/google.png'),
  },
];

const employmentTypes = [
  {id: 'fulltime', title: 'Full time'},
  {id: 'parttime', title: 'Part time'},
  {id: 'contract', title: 'Contract'},
  {id: 'temporary', title: 'Temporary'},
  {id: 'volunteer', title: 'Volunteer'},
  {id: 'apprenticeship', title: 'Apprenticeship'},
];

const FormField = ({
  label,
  onPress,
  value,
  required,
}: {
  label: string;
  onPress: () => void;
  value?: string;
  required?: boolean;
}) => (
  <TouchableOpacity style={styles.fieldContainer} onPress={onPress}>
    <View>
      <Text style={styles.fieldLabel}>
        {label}
        {required && <Text style={styles.requiredAsterisk}>*</Text>}
      </Text>
      {value && <Text style={styles.fieldValue}>{value}</Text>}
    </View>
    {value ? (
      <Image source={editIcon} style={styles.editIcon} />
    ) : (
      <Image source={plusIcon} style={styles.plusIcon} />
    )}
  </TouchableOpacity>
);

const RadioButton = ({
  selected,
  onPress,
  title,
  description,
}: {
  selected: boolean;
  onPress: () => void;
  title: string;
  description: string;
}) => (
  <TouchableOpacity style={styles.radioContainer} onPress={onPress}>
    <View style={styles.radioContent}>
      <Text style={styles.radioTitle}>{title}</Text>
      <Text style={styles.radioDescription}>{description}</Text>
    </View>
    <View style={[styles.radioButton, selected && styles.radioButtonSelected]}>
      {selected && <View style={styles.radioButtonInner} />}
    </View>
  </TouchableOpacity>
);

const LocationModal = ({
  visible,
  onClose,
  onSelect,
}: {
  visible: boolean;
  onClose: () => void;
  onSelect: (location: string) => void;
}) => {
  const [searchQuery, setSearchQuery] = useState('');

  const filteredLocations = locations.filter(location =>
    location.toLowerCase().includes(searchQuery.toLowerCase()),
  );

  return (
    <Modal visible={visible} animationType="slide" transparent={true}>
      <View style={styles.modalContainer}>
        <View style={styles.modalContent}>
          <Text style={styles.modalTitle}>Location</Text>
          <View style={styles.searchContainer}>
            <Image source={SearchIcon} style={styles.searchIcon} />
            <TextInput
              style={styles.searchInput}
              placeholder="Search"
              value={searchQuery}
              onChangeText={setSearchQuery}
            />
            {searchQuery !== '' && (
              <TouchableOpacity onPress={() => setSearchQuery('')}>
                <Text style={styles.clearSearch}>x</Text>
              </TouchableOpacity>
            )}
          </View>
          <FlatList
            data={filteredLocations}
            keyExtractor={item => item}
            renderItem={({item}) => (
              <TouchableOpacity
                style={styles.locationItem}
                onPress={() => {
                  onSelect(item);
                  onClose();
                }}>
                <Text>{item}</Text>
              </TouchableOpacity>
            )}
          />
        </View>
      </View>
    </Modal>
  );
};

const CompanyModal = ({
  visible,
  onClose,
  onSelect,
}: {
  visible: boolean;
  onClose: () => void;
  onSelect: (company: (typeof companies)[0]) => void;
}) => {
  const [searchQuery, setSearchQuery] = useState('');

  const filteredCompanies = companies.filter(
    company =>
      company.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      company.industry.toLowerCase().includes(searchQuery.toLowerCase()),
  );

  return (
    <Modal visible={visible} animationType="slide" transparent={true}>
      <View style={styles.modalContainer}>
        <View style={styles.modalContent}>
          <Text style={styles.modalTitle}>Company</Text>
          <View style={styles.searchContainer}>
            <Image source={SearchIcon} style={styles.searchIcon} />
            <TextInput
              style={styles.searchInput}
              placeholder="Search"
              value={searchQuery}
              onChangeText={setSearchQuery}
            />
            {searchQuery !== '' && (
              <TouchableOpacity onPress={() => setSearchQuery('')}>
                <Text style={styles.clearSearch}>x</Text>
              </TouchableOpacity>
            )}
          </View>
          <FlatList
            data={filteredCompanies}
            keyExtractor={item => item.id}
            renderItem={({item}) => (
              <TouchableOpacity
                style={styles.companyItem}
                onPress={() => {
                  onSelect(item);
                  onClose();
                }}>
                <Image source={item.logo} style={styles.companyLogo} />
                <View style={styles.companyInfo}>
                  <Text style={styles.companyName}>{item.name}</Text>
                  <Text style={styles.companyIndustry}>
                    Company • {item.industry}
                  </Text>
                </View>
              </TouchableOpacity>
            )}
          />
        </View>
      </View>
    </Modal>
  );
};

const EmploymentTypeModal = ({
  visible,
  onClose,
  selectedType,
  onSelect,
}: {
  visible: boolean;
  onClose: () => void;
  selectedType: string;
  onSelect: (type: string) => void;
}) => (
  <Modal visible={visible} animationType="slide" transparent={true}>
    <View style={styles.modalContainer}>
      <View style={styles.modalContent}>
        <View style={styles.modalHeader}>
          <TouchableOpacity onPress={onClose}>
            <Text style={styles.closeButton}>X</Text>
          </TouchableOpacity>
        </View>
        <Text style={styles.modalTitleEM}>Choose Employee Type</Text>
        <Text style={styles.modalSubtitle}>
          Determine and choose the type of work according to what you want
        </Text>
        <View style={styles.radioGroup}>
          {employmentTypes.map(type => (
            <RadioButton
              key={type.id}
              selected={selectedType === type.title}
              onPress={() => {
                onSelect(type.title);
                onClose();
              }}
              title={type.title}
              description={''}
            />
          ))}
        </View>
      </View>
    </View>
  </Modal>
);

const AddJobPage = ({navigation}:any) => {
  const [jobPositionModalVisible, setJobPositionModalVisible] = useState(false);
  const [selectedJobPosition, setSelectedJobPosition] = useState('');
  const [workplaceModalVisible, setWorkplaceModalVisible] = useState(false);
  const [selectedWorkplace, setSelectedWorkplace] = useState('');
  const [selectedLocation, setSelectedLocation] = useState('');
  const [locationModalVisible, setLocationModalVisible] = useState(false);
  const [companyModalVisible, setCompanyModalVisible] = useState(false);
  const [selectedCompany, setSelectedCompany] = useState<
    (typeof companies)[0] | null
  >(null);
  const [employmentTypeModalVisible, setEmploymentTypeModalVisible] =
    useState(false);
  const [selectedEmploymentType, setSelectedEmploymentType] = useState('');
  const [searchQuery, setSearchQuery] = useState('');

  const filteredJobPositions = jobPositions.filter(position =>
    position.toLowerCase().includes(searchQuery.toLowerCase()),
  );

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity>
          <Text style={styles.closeButton}>X</Text>
        </TouchableOpacity>
        <TouchableOpacity  onPress={() => navigation.navigate('JobShare')} >
          <Text style={styles.postButton}>Post</Text>
        </TouchableOpacity>
      </View>
      <ScrollView style={styles.content}>
        <Text style={styles.title}>Add a job</Text>
        <FormField
          label="Job position"
          onPress={() => setJobPositionModalVisible(true)}
          value={selectedJobPosition}
        />
        <FormField
          label="Type of workplace"
          onPress={() => setWorkplaceModalVisible(true)}
          value={selectedWorkplace}
        />
        <FormField
          label="Job location"
          onPress={() => setLocationModalVisible(true)}
          value={selectedLocation}
        />
        <FormField
          label="Company"
          onPress={() => setCompanyModalVisible(true)}
          value={selectedCompany?.name}
        />
        <FormField
          label="Employment type"
          onPress={() => setEmploymentTypeModalVisible(true)}
          value={selectedEmploymentType}
        />
        <FormField
          label="Description"
          value="Lorem ipsum dolor sit amet,
          consectetur adipiscing elit.
          Lectus id commodo egestas metus interdum dolor."
          onPress={() => {}}
        />
      </ScrollView>

      {/* Job Position Modal */}
      <Modal
        visible={jobPositionModalVisible}
        animationType="slide"
        transparent={true}>
        <View style={styles.modalContainer}>
          <View style={styles.modalContent}>
            <Text style={styles.modalTitle}>Job Position</Text>
            <View style={styles.searchContainer}>
              <Image source={SearchIcon} style={styles.searchIcon} />
              <TextInput
                style={styles.searchInput}
                placeholder="Search"
                value={searchQuery}
                onChangeText={setSearchQuery}
              />
              {searchQuery !== '' && (
                <TouchableOpacity onPress={() => navigation.goBack()}>
                  <Text style={styles.clearSearch}>x</Text>
                </TouchableOpacity>
              )}
            </View>
            <FlatList
              data={filteredJobPositions}
              keyExtractor={item => item}
              renderItem={({item}) => (
                <TouchableOpacity
                  style={styles.jobItem}
                  onPress={() => {
                    setSelectedJobPosition(item);
                    setJobPositionModalVisible(false);
                  }}>
                  <Text>{item}</Text>
                </TouchableOpacity>
              )}
            />
          </View>
        </View>
      </Modal>

      <Modal
        visible={workplaceModalVisible}
        animationType="slide"
        transparent={true}>
        <View style={styles.modalContainer}>
          <View style={styles.modalContent}>
            <View style={styles.workplaceModalHeader}>
              <TouchableOpacity onPress={() => setWorkplaceModalVisible(false)}>
                <Text style={styles.closeButton}>X</Text>
              </TouchableOpacity>
            </View>
            <Text style={styles.workplaceModalTitle}>
              Choose the type of workplace
            </Text>
            <Text style={styles.workplaceModalSubtitle}>
              Decide and choose the type of place to work according to what you
              want
            </Text>
            <View style={styles.radioGroup}>
              {workplaceTypes.map(type => (
                <RadioButton
                  key={type.id}
                  selected={selectedWorkplace === type.title}
                  onPress={() => {
                    setSelectedWorkplace(type.title);
                    setWorkplaceModalVisible(false);
                  }}
                  title={type.title}
                  description={type.description}
                />
              ))}
            </View>
          </View>
        </View>
      </Modal>

      <LocationModal
        visible={locationModalVisible}
        onClose={() => setLocationModalVisible(false)}
        onSelect={location => {
          setSelectedLocation(location);
          setLocationModalVisible(false);
        }}
      />

      <CompanyModal
        visible={companyModalVisible}
        onClose={() => setCompanyModalVisible(false)}
        onSelect={company => {
          setSelectedCompany(company);
          setCompanyModalVisible(false);
        }}
      />

      <EmploymentTypeModal
        visible={employmentTypeModalVisible}
        onClose={() => setEmploymentTypeModalVisible(false)}
        selectedType={selectedEmploymentType}
        onSelect={setSelectedEmploymentType}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  closeButton: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  postButton: {
    fontSize: 16,
    color: '#ff9800',
  },
  content: {
    flex: 1,
    padding: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 24,
  },
  fieldContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  fieldLabel: {
    fontSize: 16,
  },
  fieldValue: {
    fontSize: 16,
    color: '#666',
  },
  plusIcon: {
    width: 20,
    height: 20,
    tintColor: '#ff9800',
  },
  modalContainer: {
    flex: 1,
    justifyContent: 'flex-end',
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
  },
  modalContent: {
    backgroundColor: '#fff',
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    padding: 16,
    maxHeight: '80%',
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 16,
  },
  modalHeader: {
    alignItems: 'flex-start',
    marginBottom: 16,
  },
  modalTitleEM: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
    textAlign: 'center',
  },
  modalSubtitle: {
    fontSize: 14,
    color: '#666',
    marginBottom: 24,
    textAlign: 'center',
  },
  searchContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    paddingHorizontal: 8,
    marginBottom: 16,
  },
  searchIcon: {
    width: 20,
    height: 20,
    marginRight: 8,
  },
  searchInput: {
    flex: 1,
    height: 40,
  },
  clearSearch: {
    fontSize: 18,
    color: '#666',
    padding: 4,
  },
  jobItem: {
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  requiredAsterisk: {
    color: '#ff9800',
    marginLeft: 4,
  },
  fieldValuew: {
    fontSize: 14,
    color: '#666',
  },
  editIcon: {
    width: 16,
    height: 16,
    tintColor: '#ff9800',
  },
  workplaceModalHeader: {
    alignItems: 'flex-start',
    marginBottom: 16,
  },
  workplaceModalTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  workplaceModalSubtitle: {
    fontSize: 14,
    color: '#666',
    marginBottom: 24,
  },
  radioGroup: {
    marginTop: 16,
  },
  radioContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    justifyContent: 'space-between',
  },
  radioContent: {
    flex: 1,
  },
  radioTitle: {
    fontSize: 16,
    marginBottom: 4,
  },
  radioDescription: {
    fontSize: 14,
    color: '#666',
  },
  radioButton: {
    width: 24,
    height: 24,
    borderRadius: 12,
    borderWidth: 2,
    borderColor: '#ddd',
    marginLeft: 16,
    justifyContent: 'center',
    alignItems: 'center',
  },
  radioButtonSelected: {
    borderColor: '#ff9800',
  },
  radioButtonInner: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: '#ff9800',
  },
  clearButton: {
    padding: 4,
  },
  clearButtonText: {
    fontSize: 18,
    color: '#666',
  },
  locationList: {
    flex: 1,
  },
  locationItem: {
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  locationText: {
    fontSize: 16,
  },
  companyList: {
    flex: 1,
  },
  companyItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  companyLogo: {
    width: 40,
    height: 40,
    borderRadius: 20,
    marginRight: 12,
  },
  companyInfo: {
    flex: 1,
  },
  companyName: {
    fontSize: 16,
    fontWeight: '500',
    marginBottom: 2,
  },
  companyIndustry: {
    fontSize: 14,
    color: '#666',
  },
});

export default AddJobPage;

