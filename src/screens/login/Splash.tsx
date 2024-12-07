import React, { useEffect } from 'react';
import { StyleSheet, View, Image } from 'react-native';

const SplashScreen = ({ navigation }: { navigation: any }) => {
    useEffect(() => {
        const timer = setTimeout(() => {
            navigation.replace('Login');
        }, 3000);

        return () => clearTimeout(timer);
    }, [navigation]);

    return (
        <View style={styles.container}>
            <Image
                source={require('../../assets/PNG/Logo3.png')}
                style={styles.logo}
            />
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#1b59d6',
    },
    logo: {
        width: 200,
        height: 200,
        resizeMode: 'contain',
    },
});

export default SplashScreen;
