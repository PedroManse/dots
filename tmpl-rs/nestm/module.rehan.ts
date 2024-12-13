#input PWD
#input service_name
#set ServiceName service_name [UpperCaseFirst()]
#filename {PWD}/module.ts
#done
import {{ Module }} from '@nestjs/common';
import {{ {ServiceName}Service }} from './service';
import {{ {ServiceName}Controller }} from './controller';

@Module({{
  controllers: [{ServiceName}Controller],
  providers: [{ServiceName}Service],
}})
export class {ServiceName}Module {{}}

