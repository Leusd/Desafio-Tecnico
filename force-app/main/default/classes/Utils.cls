public with sharing class Utils {

    public static Boolean validaCNPJ(String cnpj){
        // Remove caracteres especiais
        cnpj = cnpj.replaceAll('[^0-9]', '');

        // Verifica se o CNPJ tem 14 dígitos
        if (cnpj.length() != 14) {
            return false;
        }

        // Verifica dígitos verificadores
        Integer digito1 = calcularDigito(cnpj.substring(0, 12), 5);
        Integer digito2 = calcularDigito(cnpj.substring(0, 13), 6);

        return cnpj.substring(12, 14) == String.valueOf(digito1) + String.valueOf(digito2);
    }

    public static Boolean validaCPF(String cpf){
        // Remove caracteres especiais
        cpf = cpf.replaceAll('[^0-9]', '');

        // Verifica se o CPF tem 11 dígitos
        if (cpf.length() != 11) {
            return false;
        }

        // Verifica dígitos verificadores
        Integer digito1 = calcularDigito(cpf.substring(0, 9), 10);
        Integer digito2 = calcularDigito(cpf.substring(0, 10), 11);

        return cpf.substring(9, 11) == String.valueOf(digito1) + String.valueOf(digito2);
    }

    private static Integer calcularDigito(String parte, Integer peso) {
        Integer soma = 0;
        for (Integer i = 0; i < parte.length(); i++) {
            soma += Integer.valueOf(parte.substring(i, i + 1)) * peso;
            peso--;
        }
        Integer resto = Math.mod(soma, 11);
        if (resto < 2) {
            return 0;
        } else {
            return 11 - resto;
        }
    }  
}