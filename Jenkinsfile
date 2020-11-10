
timestamps {
    ansiColor('xterm') {
        node {
            stage("⬇️ Setup") {
                checkout scm
            }
            def dockerRepository = "registry.rd.lan/bonitasoft"
            def mysql80Image = "mysql-8.0.14"
            def postgres96Image = "postgres-9.6"
            def postgres11Image = "postgres-11"
            def sqlserver2017Image = "sqlserver-2017"
            def sqlserver2019Image = "sqlserver-2019"

            // express edition: with 11Go tablespace limit
            // works as expected for CI/test purpose
// Base image is no longer available on Docker hub, for License respect violations:
//             def oracle11gImage = "oracle-11g"

            // enterprise edition: from oracle official repo
            // required to restore large databases
            def oracle12cImage = "oracle-12c-ee"


            def mysql80Version = "1.0.2-UTF8MB4"
            def postgres96Version = "1.0.0"
            def postgres11Version = "0.0.2"
            def oracle12cVersion = "0.1.0"
            def sqlserver2017Version = "CU19-1.0.0"
            def sqlserver2019Version = "1.1.6"

            def dockerTasks = [:]

            dockerTasks["mysql"] = {
                stage("$mysql80Image") {
                    sh """
                        docker build -t "$dockerRepository/$mysql80Image" docker/mysql/mysql-8.0
                        docker build -t "$dockerRepository/$mysql80Image:$mysql80Version" docker/mysql/mysql-8.0

                        docker push $dockerRepository/$mysql80Image
                        docker push $dockerRepository/$mysql80Image:$mysql80Version
                        """
                }
            }
            dockerTasks["postgres"] = {
                stage("$postgres96Image") {
                    sh """
                        docker build -t "$dockerRepository/$postgres96Image" docker/postgres/9.6
                        docker tag "$dockerRepository/$postgres96Image" "$dockerRepository/$postgres96Image:$postgres96Version"
                        docker push $dockerRepository/$postgres96Image
                        docker push $dockerRepository/$postgres96Image:$postgres96Version
                        """
                }
                stage("$postgres11Image") {
                    sh """
                        docker build -t "$dockerRepository/$postgres11Image" docker/postgres/11
                        docker tag "$dockerRepository/$postgres11Image" "$dockerRepository/$postgres11Image:$postgres11Version"
                        docker push $dockerRepository/$postgres11Image
                        docker push $dockerRepository/$postgres11Image:$postgres11Version
                        """
                }
            }
//             dockerTasks["oracle"] = {
//                 stage('oracle 12c EE') {
//                     sh """
//                         docker login --username rd.user@bonitasoft.com --password Thu9H@teMe container-registry.oracle.com
//                         docker build -t "$dockerRepository/$oracle12cImage" docker/oracle/12c-ee
//                         docker push $dockerRepository/$oracle12cImage
//
//                         docker build -t "$dockerRepository/$oracle12cImage:$oracle12cVersion" docker/oracle/12c-ee
//                         docker push $dockerRepository/$oracle12cImage:$oracle12cVersion
//                         """
//                 }
//             }
//             dockerTasks["sql server"] = {
//                 stage("$sqlserver2017Image") {
//                     sh """
//                        docker build -t "$dockerRepository/$sqlserver2017Image" docker/sqlserver/sqlserver-2017
//                        docker build -t "$dockerRepository/$sqlserver2017Image:$sqlserver2017Version" docker/sqlserver/sqlserver-2017
//
//                        docker push $dockerRepository/$sqlserver2017Image
//                        docker push $dockerRepository/$sqlserver2017Image:$sqlserver2017Version
//                         """
//                 }
//                 stage("$sqlserver2019Image") {
//                     sh """
//                        docker build -t "$dockerRepository/$sqlserver2019Image" docker/sqlserver/sqlserver-2019
//                        docker build -t "$dockerRepository/$sqlserver2019Image:$sqlserver2019Version" docker/sqlserver/sqlserver-2019
//
//                        docker push $dockerRepository/$sqlserver2019Image
//                        docker push $dockerRepository/$sqlserver2019Image:$sqlserver2019Version
//                         """
//                 }
//             }

            parallel dockerTasks
        }
    }
}