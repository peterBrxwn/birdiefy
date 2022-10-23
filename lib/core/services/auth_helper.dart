import 'package:fiber/features/bank/bloc/bank_bloc.dart';
import 'package:fiber/features/bank/services/repo.dart';
import 'package:fiber/features/batch/bloc/batch_bloc.dart';
import 'package:fiber/features/batch/services/repo.dart';
import 'package:fiber/features/category/bloc/category_bloc.dart';
import 'package:fiber/features/category/services/repo.dart';
import 'package:fiber/features/client/bloc/client_bloc.dart';
import 'package:fiber/features/client/services/repo.dart';
import 'package:fiber/features/company/domain/entity/company_entity.dart';
import 'package:fiber/features/company/services/repo.dart';
import 'package:fiber/features/company_settings/bloc/company_settings_bloc.dart';
import 'package:fiber/features/company_settings/services/repo.dart';
import 'package:fiber/features/app_data/bloc/app_data_bloc.dart';
import 'package:fiber/features/device/bloc/device_bloc.dart';
import 'package:fiber/features/device/domain/entity/device_entity.dart';
import 'package:fiber/features/device/services/repo.dart';
import 'package:fiber/features/inventory/bloc/inventory_bloc.dart';
import 'package:fiber/features/inventory/services/repo.dart';
import 'package:fiber/features/inventory_batch/services/repo.dart';
import 'package:fiber/features/loss/domain/entity/loss_entity.dart';
import 'package:fiber/features/loss/services/repo.dart';
import 'package:fiber/features/payment/services/repo.dart';
import 'package:fiber/features/restock/domain/entity/restock_entity.dart';
import 'package:fiber/features/restock/services/repo.dart';
import 'package:fiber/features/sale/domain/entity/sale_entity.dart';
import 'package:fiber/features/sale/services/repo.dart';
import 'package:fiber/features/staff/bloc/staff_bloc.dart';
import 'package:fiber/features/staff/domain/entity/staff_entity.dart';
import 'package:fiber/features/staff/services/services.dart';
import 'package:fiber/features/staff_setting/services/repo.dart';
import 'package:fiber/features/supplier/services/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void initBlocs({
  required List<String>? appData,
  required BuildContext context,
  required Company company,
  required Device device,
  required Staff staff,
}) {
  final companyId = company.id!;
  final deviceId = device.deviceId;
  final staffId = staff.id!;
  context.read<BankImpl>().init(companyId: companyId);
  context.read<BatchImpl>().init(companyId: companyId);
  context.read<CategoryImpl>().init(companyId: companyId);
  context.read<ClientImpl>().init(companyId: companyId);
  context.read<CompanyImpl>().init(companyId: companyId, staffId: staffId);
  context.read<CompanySettingsImpl>().init(companyId: companyId);
  context.read<DeviceImpl>().init(
        companyId: companyId,
        deviceId: deviceId,
        staffId: staffId,
      );
  context.read<InventoryImpl>().init(companyId: companyId);
  context.read<InventoryBatchImpl<Loss>>().init(companyId: companyId);
  context.read<InventoryBatchImpl<Restock>>().init(companyId: companyId);
  context.read<InventoryBatchImpl<Sale>>().init(companyId: companyId);
  context.read<LossImpl>().init(companyId: companyId);
  context.read<PaymentImpl<Restock>>().init(companyId: companyId);
  context.read<PaymentImpl<Sale>>().init(companyId: companyId);
  context.read<RestockImpl>().init(companyId: companyId);
  context.read<SaleImpl>().init(companyId: companyId);
  context.read<StaffImpl>().init(companyId: companyId);
  context.read<StaffSettingImpl>().init(companyId: companyId, staffId: staffId);
  context.read<SupplierImpl>().init(companyId: companyId);

  context.read<AppDataBloc>().add(
        InitAppData(
          appData: appData,
          company: company,
          staff: staff,
        ),
      );
  context.read<BankBloc>().add(StreamBank());
  context.read<BatchBloc>().add(StreamBatch());
  context.read<CategoryBloc>().add(StreamCategory());
  context.read<ClientBloc>().add(StreamClient());
  context.read<CompanySettingsBloc>().add(StreamCompanySettings());
  context.read<DeviceBloc>().add(
        StreamDevice(
          lastReceiptId: device.lastReceiptId,
          uniqueReceiptId: device.index!,
        ),
      );
  context.read<InventoryBloc>().add(StreamInventory());
  context.read<StaffBloc>().add(StreamStaff());
}
